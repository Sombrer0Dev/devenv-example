#!/bin/bash

# Путь к папке с ansible playbook и инвентарным файлом
ANSIBLE_DIR="$(pwd)/ansible"
OUTPUT_FILE="ansible_benchmark_results.txt"
INVENTORY_FILE="$ANSIBLE_DIR/inventory"

# Функция для форматированного вывода времени
format_time() {
    echo "$1" | awk '{ printf "%.2f", $1 }'
}

echo "Запуск бенчмарка для Ansible..."
echo "Рабочая директория: $ANSIBLE_DIR"
echo "Результаты будут сохранены в: $OUTPUT_FILE"
echo ""

cd "$ANSIBLE_DIR" || { echo "Ошибка: не удалось перейти в $ANSIBLE_DIR"; exit 1; }

# Проверяем наличие инвентарного файла
if [[ ! -f "$INVENTORY_FILE" ]]; then
    echo "Ошибка: инвентарный файл '$INVENTORY_FILE' не найден!"
    exit 1
fi
echo "===== Очистка Andible ====="
ansible-playbook -i "$INVENTORY_FILE" teardown.yml > /dev/null 2>&1

# --- Запуск Ansible Playbook ---
echo "Измеряется время выполнения playbook..."
start_playbook=$(date +%s.%N)
ansible-playbook -i "$INVENTORY_FILE" playbook.yml > /dev/null 2>&1
end_playbook=$(date +%s.%N)

playbook_time=$(echo "$end_playbook - $start_playbook" | bc)

# --- Вывод в консоль ---
echo ""
echo "⏱️ Время выполнения Ansible playbook: $(format_time "$playbook_time") секунд"

# --- Запись в файл (добавление результатов) ---
{
    echo "===== Ansible Benchmark Results ====="
    echo "Дата: $(date)"
    echo "Время выполнения Ansible playbook: $(format_time "$playbook_time") секунд"
    echo "====================================="
} >> "$OUTPUT_FILE"  # Здесь используется ">>" для добавления в файл

echo ""
echo "Результаты сохранены в $OUTPUT_FILE"
