# ssh_sm
SSH Server Manager v1
(c) Urupin 2025
https://github.com/Urupin/ssh_sm

Если вам доводится администрировать большое количество серверов, это решение для вас. Теперь нужный сервер открывается двойным кликом по иконке из папки. Нет необходимости запоминать где-то пароли к каждому серверу и переживать, что они куда-то уплывут. Достаточно запомнить один пинкод для подключения ко всей инфраструктуре.
Согласно файлу с конфигурациями серверов servers.conf, скрипт генерирует файлы для подключения к серверам, шифрует пароли единым пинкодом.
1. Подготовьте файл с конфигурациями подключений servers.conf согласно образцу. Если при соединении используется не пароль, а ключ, то пропишите там к нему путь, и параметр use_key=yes
2. Можно дополнительно прописать пути в самом скрипте. Запустите скрипт создания подключений setup_ssh_connection.sh
3. После успешной отработки скрипта по каждому серверу сгенерируется файл для подключения и шифрованый файл с SSH паролем этого сервера. Рекомендуется удалить файл servers.conf в целях безопасности или заархивировать со сложным паролем.
4. Для удобсва работы, файлы подключений можно разложить по папкам.
5. При запуске соединения для расшифровки пароля будет запрашиваться пинкод, и для удобства дальнейшей работы пароль подсвечивается в потолке текущей сессии терминала.

Всё решение открытым кодом. Проверено на Ubuntu 22.04.

===========

If you manage a large number of servers, this solution is for you. Now, you can open the desired server with a double click on its icon in a folder. There’s no need to remember passwords for each server or worry about them being leaked. You only need to remember one PIN code to access the entire infrastructure. Based on the servers configuration file `servers.conf`, the script generates server connection files and encrypts passwords with a single PIN code.

- **Prepare a configuration file**: Create a `servers.conf` file following the provided template. If a key is used instead of a password for the connection, specify the path to the key in the file and set the parameter `use_key=yes`.  
- **Adjust paths in the script**: Optionally, you can specify paths directly in the script. Run the connection setup script `setup_ssh_connection.sh`.  
- **Generated files**: After successful execution, the script will generate a connection file and an encrypted file containing the SSH password for each server. For security purposes, it is recommended to delete the `servers.conf` file or archive it with a strong password.  
- **Organization**: For convenience, you can organize the connection files into folders.  
- **Usage**: When initiating a connection, the PIN code will be requested to decrypt the password. For ease of use, the decrypted password will be displayed at the top of the terminal session.

This solution is fully open-source and has been tested on Ubuntu 22.04.
