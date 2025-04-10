#!/usr/bin/env bash

set -e

# --- Настройки ---
DEVCONTAINER_DIR="$(pwd)"
OUTPUT_FILE="devcontainer_benchmark_results.txt"
WORKSPACE="."
DEBUG_LOG="devcontainer_debug.log"

# Формат вывода времени
format_time() {
  LC_NUMERIC=C printf "%.2f" "$(echo "$1" | LC_NUMERIC=C awk '{printf "%f", $1}')"
}

echo "🚀 Запуск Devcontainer-бенчмарка (без кэша)"
echo "Рабочая директория: $DEVCONTAINER_DIR"
echo "Результаты будут сохранены в: $OUTPUT_FILE"
echo ""

cd "$DEVCONTAINER_DIR" || { echo "❌ Ошибка: не удалось перейти в $DEVCONTAINER_DIR"; exit 1; }

# --- devcontainer up без кэша ---
echo "⏳ Запуск devcontainer без кэша..."

start_up=$(date +%s.%N)
devcontainer up --workspace-folder "$WORKSPACE" --remove-existing-container --build-no-cache 2>&1 | tee "$DEBUG_LOG"
end_up=$(date +%s.%N)

up_time=$(awk "BEGIN {print $end_up - $start_up}")

# --- Быстрый вход (exec) ---
echo "⏳ Проверка входа в контейнер..."

start_exec=$(date +%s.%N)
devcontainer exec --workspace-folder "$WORKSPACE" echo "ok" > /dev/null 2>&1
end_exec=$(date +%s.%N)

exec_time=$(awk "BEGIN {print $end_exec - $start_exec}")

# --- Вывод ---
echo ""
echo "🐳 Время запуска (без кэша): $(format_time "$up_time") секунд"
echo "🔁 Время входа в контейнер:   $(format_time "$exec_time") секунд"

# --- Запись в файл ---
{
  echo "===== Devcontainer Benchmark Results (No Cache) ====="
  echo "Время запуска: $(format_time "$up_time") секунд"
  echo "Время входа:   $(format_time "$exec_time") секунд"
  echo "====================================================="
} >> "$OUTPUT_FILE"

echo ""
echo "✅ Результаты сохранены в $OUTPUT_FILE"
#
