# Greenplum train

Тестовый стенд для оттачивания навыков администрирования Greenplum

## Для работы требуются:

* `docker`
* `just`

## Команды just:

* `just build` - собирает базовый образ `greenplum`
* `just start` - запускает сервера кластера(вызывает `docker compose up`)
* `just stop` - останавливает сервера кластера(вызывает `docker compose down`)
* `just stop` - перезапуск серверов кластера
* `just clean-ssh` - очищает ssh конфигурации для всех серверов