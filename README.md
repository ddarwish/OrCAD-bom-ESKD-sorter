OrCAD-bom-ESKD-sorter
=====================

Скрипт для автоматической сортировки компонентов из OrCAD'овского bom-файла согласно требованиям ЕСКД


Использование
---------------------

1. Сгенериовать бом-файл в оркаде используя следующие опции
  - Header: Part Reference\tPart Type\tKOMP_NAME\tQuantity\tValue\tДокумент\tPart Number\tKOMP_ID\
  - Property string: {Reference}\t{Part Type}\t{KOMP_NAME}\t{Quantity}\t{Value}\t{Документ}\t{Part Number}\t{KOMP_ID}
  - активировать чекбокс "open in Excel"!
2. выполнить следующую комманду
  - awk -f /script_path/genlistfrombom.awk < /bom_path/DESHK_301411_161_E3.BOM > /sorted_bom_path/DESHK_301411_161_E3.txt