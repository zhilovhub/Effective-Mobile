#!/bin/sh

i=1
mkdir trash

while true
do
        echo "Iteration i = $i: $(date)" > trash/iter$i
        i=$((i+1))
        sleep 5
done
