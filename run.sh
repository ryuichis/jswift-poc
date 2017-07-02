#!/bin/bash

set -e

make
.build/debug/jswift $@

echo "cat Main.j"
cat Main.j

echo "---------"
echo "krakatau"
python Krakatau/assemble.py Main.j

echo "---------"
echo "javap"
javap -c Main.class

echo "------------"
echo "run"
java Main
