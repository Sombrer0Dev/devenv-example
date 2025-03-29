# Проект исследований инструментов воспроизведения окружений разработки


| Инструмент    | Изоляция  |Воспроизводимость| Первый запуск | Запуск | Зависимости |
|---------------|-----------|-----------------|---------------|--------|-------------|
|   Vagrant     |   full    |  env based      |   1m 40s      |   5s   | VB          |
| DevContainers |   full    |  env based      |   1m 50s      |   2s   | Docker      |
| Nix Shell	    |  partial  |  full           |   20s	        |   0.5s | none        |
| Ansible	      |  none     |  full           |	  30s	        |   0s   | none        |


System:  
CPU: AMD Ryzen 5 7500f  
GPU: AMD Radeon RX 7800 XT  
RAM: 32GB 6000Mhz DDR5  
DISK: 500gb io speed 6000MB/s  
NET: ~400mb/s  

Все замеры производились на проекте:
https://github.com/Sombrer0Dev/advent-of-code-2024-rust

Зависимости проекта:
 - rustc
 - cargo
 - rust пакеты:
   - clap
   - dotenv
   - regex
