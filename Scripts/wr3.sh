#!/bin/bash
echo "Введите число:"
read num
if [ $((num % 2)) -eq 0 ]; then
    echo "Число $num четное."
else
    echo "Число $num нечетное."
fi