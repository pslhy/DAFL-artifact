#!/bin/bash
GIT_URL="https://github.com/bminor/binutils-gdb.git"
DIRNAME="binutils-515f23e"
VERSION="515f23e"
CONFIG_OPTIONS="--disable-shared --disable-gdb \
                 --disable-libdecnumber --disable-readline \
                 --disable-sim LIBS='-ldl -lutil'"

rm -rf $DIRNAME
git clone $GIT_URL $DIRNAME
cd $DIRNAME
./configure $CONFIG_OPTIONS || exit 1
## Parallel building according to https://github.com/aflgo/aflgo/issues/59
## Altohough an issue with parallel building is observed in libxml (https://github.com/aflgo/aflgo/issues/41), 
## We have not yet encountered a problem with binutils.
make -j || exit 1
cd ../
cp $DIRNAME/binutils/nm-new ./nm || exit 1
