#!/bin/bash

# Скрипт для генерации sh файлов с автоматической настройкой подключения к серверам


CONFIG_FILE="./servers.conf" # Файл с конфигурациями подключений к серверам
PIN_CODE="" 
ENCRYPTED_FOLDER="."  # Папка для хранения зашифрованных паролей и скриптов

# Проверка и установка необходимых пакетов
install_dependencies() {
    echo "Проверка и установка необходимых зависимостей..."
    for package in sshpass gnupg; do
        if ! dpkg -l | grep -q $package; then
            echo "Установка $package..."
            sudo apt-get update
            sudo apt-get install -y $package
        else
            echo "$package уже установлен."
        fi
    done
}

# Функция для шифрования пароля
encrypt_password() {
    local server_name=$1
    local password=$2
    local output_file="${ENCRYPTED_FOLDER}/${server_name}_password.gpg"

    echo "$password" | gpg --batch --yes --symmetric --cipher-algo AES256 --passphrase "$PIN_CODE" -o "$output_file"
    echo "Зашифрованный пароль сохранен в: $output_file"
}

# Генерация скрипта для подключения
generate_ssh_script() {
    local server_name=$1
    local host=$2
    local port=$3
    local user=$4
    local use_key=$5
    local key_path=$6
    local encrypted_password_file="${ENCRYPTED_FOLDER}/${server_name}_password.gpg"
    local script_file="${ENCRYPTED_FOLDER}/${server_name}.sh"

    # Создание скрипта подключения
    echo "Создание скрипта подключения для $server_name..."
    cat > "$script_file" <<EOF
#!/bin/bash
# Скрипт для подключения к $server_name
EOF

if [ "$use_key" = "yes" ]; then
    cat >> "$script_file" <<EOF
    echo "Подключение с использованием SSH-ключа..."
    ssh -o StrictHostKeyChecking=no -i "$key_path" -p $port $user@$host
EOF
    else
    cat >> "$script_file" <<EOF
    read -s -p "Введите PIN-код для расшифровки пароля: " PIN_CODE
    PASSWORD=\$(gpg --batch --quiet --passphrase "\$PIN_CODE" --decrypt "$encrypted_password_file")

    if [ \$? -ne 0 ]; then
        echo "Ошибка: неверный PIN-код или не удалось расшифровать пароль."
        exit 1
    fi

    echo "Подключение с использованием пароля..."
    echo \$PASSWORD
    sshpass -p "\$PASSWORD" ssh -o StrictHostKeyChecking=no -p $port $user@$host
EOF
fi

    chmod +x "$script_file"
    echo "Скрипт сохранен в: $script_file"
}

# Основная функция
main() {
    echo "Автоматическая настройка SSH-соединений"
    read -s -p "Введите PIN-код для шифрования паролей: " PIN_CODE
    echo ""

    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Ошибка: файл конфигурации $CONFIG_FILE не найден!"
        exit 1
    fi

    install_dependencies

    # Чтение файла конфигурации
    echo "Чтение конфигурации из $CONFIG_FILE..."
    servers=$(grep '^\[.*\]' "$CONFIG_FILE" | tr -d '[]')

    for server in $servers; do
        echo "Обработка сервера: $server"
        host=$(grep -A6 "^\[$server\]" "$CONFIG_FILE" | grep "host=" | cut -d '=' -f2)
        port=$(grep -A6 "^\[$server\]" "$CONFIG_FILE" | grep "port=" | cut -d '=' -f2)
        user=$(grep -A6 "^\[$server\]" "$CONFIG_FILE" | grep "user=" | cut -d '=' -f2)
        password=$(grep -A6 "^\[$server\]" "$CONFIG_FILE" | grep "password=" | cut -d '=' -f2)
        use_key=$(grep -A6 "^\[$server\]" "$CONFIG_FILE" | grep "use_key=" | cut -d '=' -f2)
        key_path=$(grep -A6 "^\[$server\]" "$CONFIG_FILE" | grep "key_path=" | cut -d '=' -f2)

        # Шифрование пароля
        if [ "$use_key" = "no" ]; then
            encrypt_password "$server" "$password"
        fi

        # Генерация скрипта
        generate_ssh_script "$server" "$host" "$port" "$user" "$use_key" "$key_path"
    done

    echo "Настройка завершена! Скрипты и пароли сохранены в $ENCRYPTED_FOLDER."
}

main
