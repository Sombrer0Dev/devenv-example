#!/usr/bin/env bash

set -e

# --- Настройки ---
NIX_DIR="$(pwd)"
OUTPUT_FILE="nix_benchmark_results.txt"
DEBUG_LOG="nix_debug.log"
NIX_CACHE_DIR="$HOME/.cache/nix/"
NIX_ENV_COMMAND="nix develop --command echo ok"  # Команда для проверки входа в окружение

# Формат вывода времени
format_time() {
  LC_NUMERIC=C printf "%.2f" "$(echo "$1" | LC_NUMERIC=C awk '{printf "%f", $1}')"
}

echo "🚀 Запуск Nix develop-бенчмарка"
echo "Рабочая директория: $NIX_DIR"
echo "Результаты будут сохранены в: $OUTPUT_FILE"
echo ""

cd "$NIX_DIR" || { echo "❌ Ошибка: не удалось перейти в $NIX_DIR"; exit 1; }

# --- Очистка кэша Nix ---
echo "🧹 Очистка кэша Nix..."
rm -rf "$NIX_CACHE_DIR"

# --- Запуск nix develop ---
echo "⏳ Запуск nix develop..."

start_up=$(date +%s.%N)
$NIX_ENV_COMMAND > /dev/null 2>&1
end_up=$(date +%s.%N)

up_time=$(awk "BEGIN {print $end_up - $start_up}")

# --- Проверка входа в окружение ---
echo "⏳ Проверка входа в окружение..."

start_exec=$(date +%s.%N)
$NIX_ENV_COMMAND > /dev/null 2>&1
end_exec=$(date +%s.%N)

exec_time=$(awk "BEGIN {print $end_exec - $start_exec}")

# --- Вывод ---
echo ""
echo "🐳 Время установки nix develop: $(format_time "$up_time") секунд"
echo "🔁 Время входа в окружение:    $(format_time "$exec_time") секунд"

# --- Запись в файл ---
{
  echo "===== Nix Develop Benchmark Results ====="
  echo "Время установки: $(format_time "$up_time") секунд"
  echo "Время входа:     $(format_time "$exec_time") секунд"
  echo "========================================="
} >> "$OUTPUT_FILE"

echo ""
echo "✅ Результаты сохранены в $OUTPUT_FILE"

