# ssh_sm
SSH Server Manager v1
(c) Urupin 2025
https://github.com/Urupin/ssh_sm

Если вы администрируете большое количество серверов, это решение для вас. Теперь нужный сервер можно открыть двойным щелчком по значку из папки. Нет необходимости запоминать пароли для каждого сервера или беспокоиться об их утечке. Достаточно помнить один пин-код для подключения ко всей инфраструктуре.  

Согласно конфигурационному файлу `servers.conf`, скрипт генерирует файлы для подключения к серверам и шифрует пароли с использованием единого пин-кода.  

### Инструкция:  
1. Подготовьте файл конфигурации подключений `servers.conf` в соответствии с образцом.  
   - Если для соединения используется ключ, а не пароль, укажите путь к ключу и добавьте параметр `use_key=yes`.  
2. При необходимости дополнительно настройте пути в самом скрипте.  
3. Запустите скрипт создания подключений `setup_ssh_connection.sh`.  

После успешной работы скрипта для каждого сервера будут сгенерированы:  
- файл для подключения,  
- зашифрованный файл с паролем SSH для этого сервера.  

**Рекомендация:**  
После завершения настройки удалите файл `servers.conf` или заархивируйте его с надежным паролем.  

### Дополнительные возможности:  
- Для удобства работы файлы подключений можно разложить по папкам.  
- При запуске соединения для расшифровки пароля потребуется ввести пин-код. Пароль будет подсвечиваться в верхней части текущей сессии терминала для упрощения работы.  

### Преимущества:  
- Решение с открытым исходным кодом.  
- Проверено на Ubuntu 22.04.  

===========

If you manage a large number of servers, this solution is for you. Now, you can open the desired server with a double click on its icon in a folder. There’s no need to remember passwords for each server or worry about them being leaked. You only need to remember one PIN code to access the entire infrastructure. Based on the servers configuration file `servers.conf`, the script generates server connection files and encrypts passwords with a single PIN code.

- **Prepare a configuration file**: Create a `servers.conf` file following the provided template. If a key is used instead of a password for the connection, specify the path to the key in the file and set the parameter `use_key=yes`.  
- **Adjust paths in the script**: Optionally, you can specify paths directly in the script. Run the connection setup script `setup_ssh_connection.sh`.  
- **Generated files**: After successful execution, the script will generate a connection file and an encrypted file containing the SSH password for each server. For security purposes, it is recommended to delete the `servers.conf` file or archive it with a strong password.  
- **Organization**: For convenience, you can organize the connection files into folders.  
- **Usage**: When initiating a connection, the PIN code will be requested to decrypt the password. For ease of use, the decrypted password will be displayed at the top of the terminal session.

This solution is fully open-source and has been tested on Ubuntu 22.04.
