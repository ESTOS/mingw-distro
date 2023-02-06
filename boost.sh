#!/bin/sh

source ./0_append_distro_path.sh

extract_file boost_1_63_0.tar

cd $X_DISTRO_BASE
mv boost_1_63_0 src
mkdir -p dest/include
cd src
./bootstrap.sh || fail_with boost 1 - EPIC FAIL

./b2 $X_B2_JOBS variant=release link=static runtime-link=static threading=multi --stagedir=$X_DISTRO_BASE/dest stage \
-sNO_BZIP2 -sBZIP2_BINARY=bz2 -sBZIP2_INCLUDE=$X_DISTRO_INC -sBZIP2_LIBPATH=$X_DISTRO_LIB \
-sNO_ZLIB -sZLIB_BINARY=z -sZLIB_INCLUDE=$X_DISTRO_INC -sZLIB_LIBPATH=$X_DISTRO_LIB || fail_with boost 2 - EPIC FAIL

cd $X_DISTRO_BASE/dest/lib
for i in *.a; do mv $i ${i%-mgw*.a}.a; done
cd $X_DISTRO_BASE
mv src/boost dest/include
mv dest boost-1.63.0

cd boost-1.63.0
7z -mx0 a ../boost-1.63.0.7z * || fail_with boost-1.63.0.7z - EPIC FAIL

cd $X_DISTRO_BASE
rm -rf src
