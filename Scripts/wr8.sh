#!/bin/bash
repo="$1"
if [ -z "$repo" ]; then
    echo "Ошибка: укажите имя репозитория."
    exit 1
fi

curl -s https://api.github.com/luzan/de$ | jq -r '.stargazers_count, .forks_count, .open_issues_count' | awk '{
    print "\033[33m⭐ Звёзды: " $1