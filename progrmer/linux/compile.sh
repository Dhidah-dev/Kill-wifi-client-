#!/bin/bash
. ../../config.cfg
pwd 
cd $prog_path_CP_64
pwd 
make clean 
find . -name "Makefile*" -delete 
git pull origin comp_linux 
/local/Qt/5.9.1/gcc_64/bin/qmake
make 
