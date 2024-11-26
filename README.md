# Effective Mobile
<hr>

### Главные файлы для ответа
- `monitor_worker.sh` и `monitor_worker@.service`

<hr>

**Примечания к решению**:
1. `test.sh` - **тестовый** скрипт, мониторинг процесса которого осуществляется
2. Для работоспособности системы нужно запускать Systemd Unit в формате
`systemctl start monitor_worker@<process_name>.service`. В качестве текущего примера
вместо `<process_name>` подставлять надо, например, `test.sh`.