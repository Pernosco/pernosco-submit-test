#!/bin/bash

mkdir -p out
rm -rf out/*
# Include a file by symbolic link
ln -s ../file.c out/file.c
# Include a generated file
cat > out/message.h << EOF
const char MESSAGE[] = "Hello World";
EOF

cc -gsplit-dwarf -g -c -o out/file.o out/file.c
cc -gsplit-dwarf -g -c -o out/main.o main.c
cc -gsplit-dwarf -g -o out/main out/file.o out/main.o
