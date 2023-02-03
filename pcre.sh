#!/bin/sh

source ./0_append_distro_path.sh

extract_file pcre-8.39.tar

patch -d /c/lwx/winbuild/gcc/pcre-8.39 -p1 < pcre-color.patch

cd /c/lwx/winbuild/gcc
mv pcre-8.39 src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=/c/lwx/winbuild/gcc/dest --disable-shared --enable-utf --enable-unicode-properties --enable-pcre16 --enable-pcre32 \
"CFLAGS=-s -O3" "CXXFLAGS=-s -O3" || fail_with pcre 1 - EPIC FAIL

make $X_MAKE_JOBS all || fail_with pcre 2 - EPIC FAIL
make install || fail_with pcre 3 - EPIC FAIL
cd /c/lwx/winbuild/gcc
rm -rf build src
mv dest pcre-8.39
cd pcre-8.39
rm -rf bin/pcre-config lib/pkgconfig lib/*.la share
cp include/pcreposix.h include/regex.h

7z -mx0 a ../pcre-8.39.7z *
