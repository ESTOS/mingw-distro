#!/bin/sh

source ./0_append_distro_path.sh

extract_file zlib-1.2.8.tar

cd $X_DISTRO_BASE
mv zlib-1.2.8 src
mkdir -p dest/include dest/lib
cd src
# -DTOO_FAR=32767 : http://optipng.sourceforge.net/pngtech/too_far.html
gcc -DTOO_FAR=32767 -s -O3 -c *.c || fail_with zlib 1 - EPIC FAIL
ar rs ../dest/lib/libz.a *.o || fail_with zlib 2 - EPIC FAIL
mv zconf.h zlib.h ../dest/include
cd $X_DISTRO_BASE
rm -rf src
mv dest zlib-1.2.8
cd zlib-1.2.8

7z -mx0 a ../zlib-1.2.8.7z *
