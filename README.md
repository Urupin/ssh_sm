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
