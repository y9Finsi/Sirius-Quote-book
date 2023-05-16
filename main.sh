#!/bin/bash

while true; do
  # Получаем название произведения
  read -p "Введите название произведения (для выхода введите 'хватит'): " book_title

  # Проверяем нужно ли заврешить программу
  if [ "$book_title" == "хватит" ]; then
    echo "программа завершена."
    exit 0
  fi
  
  # Получаем случайную цитату для данного произведения
  quote=$(grep -i "^${book_title}:" citates.txt)
  
  # Проверяем есть ли цитата
  if [ -z "$quote" ]; then
      echo "Для данного произведения не найдено цитат"
      read -p "Хотите добавить цитату для этого произведения? (y/n): " choice
  
      # Если юзер соглсаен добавляем цитату
      if [ "$choice" == "y" ]; then
          read -p "Введите цитату для произведения '$book_title': " new_quote
          last_id=$(grep -oP '\[id:\K\d+' citates.txt | tail -1)
          new_id=$((last_id + 1))
          read -p "Введите номер главы для новой цитаты: " new_chapter
          read -p "Введите номер страницы для новой цитаты: " new_page
          read -p "Введите объяснение для новой цитаты: " new_explanation
          echo "${book_title}: \"${new_quote}\" - Глава ${new_chapter}, страница ${new_page} [id:${new_id}]" >> citates.txt
          echo "id:${new_id} ${new_explanation}" >> expl.txt
          echo ""
          echo "Новая цитата с объяснением успешна добавлена в базу данных"
      else
          echo ""
      fi
  else
      # Рандомно получаем цитату с помощью shuf
      quote=$(echo "$quote" | shuf -n 1)
      
      # Извлекаем id цитаты
      id=$(echo "$quote" | sed 's/.*\[id:\([0-9]\+\)\]/\1/')
      
      # Получаем объяснение для данной цитаты
      explanation=$(grep -i "^id:${id}" expl.txt | sed 's/id:[0-9]\+//g')
      
      # Выводим цитату и объяснение
      echo ""
      echo "---------"
      echo "Цитата из ${quote/\[*\]/}"
      echo ""
      echo "Объяснение: $explanation"
      echo "---------"
      echo ""
    fi
done
