#!/bin/bash

OPTS="-std=c99 -Wall -Wextra -pedantic -O3 -flto -ffast-math"
SRCS="*.c *.m"
LIBS="-framework Cocoa"

cd src && clang -I../include -o ../output $OPTS $SRCS $LIBS && cd ..
