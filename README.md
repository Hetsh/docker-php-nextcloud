# Stationeers
Super small PHP FastCGI Process Manager.

## Running the server
```bash
docker run --detach --name php-fpm --publish 9000:9000 hetsh/php-fpm
```

## Stopping the container
```bash
docker stop php-fpm
```

## Configuration
A custom `php.ini` file can be provided with this mount option:
```bash
--mount type=bind,readonly,source="/path/to/php.ini",target="/etc/php7/php.ini"
```

## Automate startup and shutdown via systemd
```bash
systemctl enable php-fpm --now
```
The systemd unit can be found in my [GitHub](https://github.com/Hetsh/docker-php-fpm) repository.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-php-fpm)). Please feel free to ask questions, file an issue or contribute to it.