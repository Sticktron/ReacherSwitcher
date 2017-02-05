#!/bin/bash

echo "bye .DS_Store files..."
find . -name ".DS_Store" -delete

echo "Cleaning up build scraps..."
make clean
rm -rf obj
rm -rf packages
rm -rf .theos
rm -rf Settings/.theos

echo "done."
