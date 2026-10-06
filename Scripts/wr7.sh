#!/bin/bash
echo "Введите расширение файлов (например, .txt):"
read ext
find . -type f -name "*$ext" -print0 | xargs -0 echo
