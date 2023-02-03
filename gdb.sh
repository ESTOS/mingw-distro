#!/bin/sh

source ./0_append_distro_path.sh

extract_file gdb-7.12.tar

cd /c/lwx/winbuild/gcc
mv gdb-7.12 src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/lwx/winbuild/gcc/dest --disable-nls || fail_with gdb 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-O3" "LDFLAGS=-s" || fail_with gdb 2 - EPIC FAIL
make install || fail_with gdb 3 - EPIC FAIL
cd /c/lwx/winbuild/gcc
rm -rf build src
mv dest gdb-7.12
cd gdb-7.12
rm -rf include lib share

7z -mx0 a ../gdb-7.12.7z *
