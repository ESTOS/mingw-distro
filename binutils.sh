#!/bin/sh

source ./0_append_distro_path.sh

extract_file binutils-2.27.tar

cd /c/lwx/winbuild/gcc
mv binutils-2.27 src
mkdir build dest
cd build

../src/configure --disable-nls --disable-shared --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 \
--target=x86_64-w64-mingw32 --disable-multilib --prefix=/c/lwx/winbuild/gcc/dest --with-sysroot=/c/lwx/winbuild/gcc/dest \
|| fail_with binutils 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-O3" "LDFLAGS=-s" || fail_with binutils 2 - EPIC FAIL
make install || fail_with binutils 3 - EPIC FAIL
cd /c/lwx/winbuild/gcc
rm -rf build src
mv dest binutils-2.27
cd binutils-2.27
rm -rf lib/*.la share

7z -mx0 a ../binutils-2.27.7z *
