#!/bin/bash

set -e

make
.build/debug/jswift $@

echo "javap"
javap -c Main.class
echo "------------"
echo "run"
java Main
