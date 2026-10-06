#!/bin/bash

read -p "Введите имя файла: " filename

if [ -f "$filename" ]; then
    echo "Файл '$filename' существует."
else
    echo "Файл '$filename' не найден (или это не обычный файл)."
fi