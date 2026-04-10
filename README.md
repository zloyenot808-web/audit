# Ansible Playbook для запуска compliance скрипта на удаленных хостах

## Описание

Этот playbook выполняет следующие действия:
1. Подключается к удаленным хостам от имени указанного пользователя с sudo правами
2. Копирует `script.sh` на каждый хост во временную директорию
3. Делает скрипт исполняемым (`chmod +x`)
4. Запускает скрипт на каждом хосте
5. Забирает созданный отчет из директории `sftp_compliance_reports` локально
6. Удаляет скрипт и директорию с отчетами с удаленных хостов

## Структура файлов

```
.
├── playbook.yml          # Основной ansible playbook
├── script.sh             # Скрипт который будет запущен на хостах
├── ansible.cfg           # Конфигурация ansible
├── hosts.ini             # Инвентарь хостов
└── README.md             # Этот файл
```

## Настройка

### 1. Отредактируйте `hosts.ini`

Укажите ваши хосты и учетные данные:

```ini
[all]
host1 ansible_host=192.168.1.10 ansible_user=username ansible_ssh_pass=password
host2 ansible_host=192.168.1.11 ansible_user=username ansible_ssh_pass=password
```

**Варианты аутентификации:**

- **Пароль:** `ansible_ssh_pass=ваш_пароль`
- **SSH ключ:** Убедитесь что ключ добавлен в ssh-agent или укажите путь к ключу
- **Ask pass:** Используйте `-k` флаг при запуске для ввода пароля

### 2. Проверьте `script.sh`

При необходимости отредактируйте скрипт под ваши задачи. Скрипт должен создавать директорию `sftp_compliance_reports` в той же директории откуда запускается.

## Запуск

### Базовый запуск:

```bash
ansible-playbook playbook.yml
```

### С указанием инвентаря:

```bash
ansible-playbook -i hosts.ini playbook.yml
```

### С запросом пароля при подключении:

```bash
ansible-playbook -i hosts.ini playbook.yml -k
```

### С запросом пароля sudo:

```bash
ansible-playbook -i hosts.ini playbook.yml -K
```

### Для конкретных хостов:

```bash
ansible-playbook -i hosts.ini playbook.yml --limit host1
```

### С переопределением пользователя:

```bash
ansible-playbook -i hosts.ini playbook.yml -e "ansible_user=myuser"
```

## Результат

После успешного выполнения:
- В текущей директории появится папка `sftp_compliance_reports/` с поддиректориями для каждого хоста
- На удаленных хостах будут удалены `script.sh` и директория `sftp_compliance_reports`

## Структура отчетов

```
sftp_compliance_reports/
├── host1/
│   └── compliance_report.txt
├── host2/
│   └── compliance_report.txt
└── ...
```

## Требования

- Ansible 2.9+
- Python 3 на управляющей машине
- Доступ по SSH к целевым хостам
- Права sudo на целевых хостах
