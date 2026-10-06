#!/bin/bash
echo "Введите путь к файлу:"
read file
if [ -f "$file" ]; then
    echo "Количество строк в файле: $(wc -l < "$file")"
else
    echo "Файл не найден."
fi