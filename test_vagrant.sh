#!/usr/bin/env bash

# Путь к Vagrantfile
VAGRANT_DIR="$(pwd)"
OUTPUT_FILE="vagrant_benchmark_results.txt"

# Функция для форматированного вывода времени
format_time() {
  LC_NUMERIC=C printf "%.2f" "$(echo "$1" | LC_NUMERIC=C awk '{printf "%f", $1}')"
}

echo "Запуск бенчмарка Vagrant..."
echo "Рабочая директория: $VAGRANT_DIR"
echo "Результаты будут сохранены в: $OUTPUT_FILE"
echo ""

cd "$VAGRANT_DIR" || { echo "Ошибка: не удалось перейти в $VAGRANT_DIR"; exit 1; }

# --- Первый запуск (destroy + up) ---
echo "Измеряется время развертывания новой машины..."

vagrant destroy -f > /dev/null 2>&1
start_deploy=$(date +%s.%N)
vagrant up > /dev/null 2>&1
end_deploy=$(date +%s.%N)

deploy_time=$(awk "BEGIN {print $end_deploy - $start_deploy}")

# --- Вход в уже поднятую машину ---
echo "Измеряется время входа в уже развернутое окружение..."

start_ssh=$(date +%s.%N)
vagrant ssh -c "exit" > /dev/null 2>&1
end_ssh=$(date +%s.%N)

ssh_time=$(awk "BEGIN {print $end_ssh - $start_ssh}")

# --- Вывод ---
echo ""
echo "⏱️ Время развертывания новой машины: $(format_time "$deploy_time") секунд"
echo "🔐 Время входа в развернутое окружение: $(format_time "$ssh_time") секунд"

# --- Запись в файл ---
{
  echo "===== Vagrant Benchmark Results ====="
  echo "Время развертывания новой машины: $(format_time "$deploy_time") секунд"
  echo "Время входа в развернутое окружение: $(format_time "$ssh_time") секунд"
  echo "====================================="
} >> "$OUTPUT_FILE"

echo ""
echo "Результаты сохранены в $OUTPUT_FILE"

