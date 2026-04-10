#!/bin/bash
# Пример скрипта, который создает директорию sftp_compliance_reports
# и генерирует в ней отчет

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT_DIR="${SCRIPT_DIR}/sftp_compliance_reports"

mkdir -p "${REPORT_DIR}"

# Создаем файл отчета с именем хоста
hostname > "${REPORT_DIR}/compliance_report.txt"
echo "Report generated at $(date)" >> "${REPORT_DIR}/compliance_report.txt"

echo "Script completed successfully"
