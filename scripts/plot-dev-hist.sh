#!/bin/bash

dd if=/dev/urandom 2>/dev/null |\
hexdump -v -e '/1 "%u 50.5\n"' |\
./plothistgram.py 0 256 "dane1:blue;dane2:red" --sleep 1 --term "wxt" |\
gnuplot 2>/dev/null
