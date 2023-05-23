#!/bin/bash

chmod +x main.sh

if ! echo -e "преступление и наказание\nхватит\n" | ./main.sh | grep -q -f test2; then
    exit 1
fi
