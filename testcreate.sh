#!/bin/bash

chmod +x main.sh

if ! echo -e "1984\ny\nВойна — это мир, свобода — это рабство, незнание — сила.\n0\n0\nслоган (продающий)\nхватит\n" | ./main.sh | grep -q успешна; then
    exit 1
elif ! echo -e "1984\nхватит\n" | ./main.sh | grep -q "Война — это мир, свобода — это рабство, незнание — сила."; then
    exit 1
fi
