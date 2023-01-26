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
cc -gsplit-dwarf -g -c -o out/submodule.o submodule/submodule.c
cc -gsplit-dwarf -g -c -o out/submodule-private.o submodule-private/submodule-private.c
cc -gsplit-dwarf -g -c -o out/main.o main.c
cc -gsplit-dwarf -g -o out/main out/submodule.o out/submodule-private.o out/file.o out/main.o

objcopy --only-keep-debug out/main out/main.debug
objcopy --strip-all --add-gnu-debuglink=out/main.debug out/main out/main
