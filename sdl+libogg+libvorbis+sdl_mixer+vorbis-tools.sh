#!/bin/sh

source ./0_append_distro_path.sh

extract_file SDL2-2.0.5.tar
extract_file libogg-1.3.2.tar
extract_file libvorbis-1.3.5.tar
extract_file SDL2_mixer-2.0.1.zip
extract_file vorbis-tools-1.4.0.tar

patch -d $X_DISTRO_BASE/SDL2-2.0.5 -p1 < sdl-clipcursor.patch

cd $X_DISTRO_BASE

mv SDL2-2.0.5 src
mkdir build dest
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=$X_DISTRO_BASE/dest --disable-shared || fail_with SDL 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-s -O3" || fail_with SDL 2 - EPIC FAIL
make install || fail_with SDL 3 - EPIC FAIL
cd $X_DISTRO_BASE
rm -rf build src

mv libogg-1.3.2 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=$X_DISTRO_BASE/dest --disable-shared || fail_with libogg 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-s -O3" || fail_with libogg 2 - EPIC FAIL
make install || fail_with libogg 3 - EPIC FAIL
cd $X_DISTRO_BASE
rm -rf build src

mv libvorbis-1.3.5 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=$X_DISTRO_BASE/dest --disable-shared || fail_with libvorbis 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-s -O3" || fail_with libvorbis 2 - EPIC FAIL
make install || fail_with libvorbis 3 - EPIC FAIL
cd $X_DISTRO_BASE
rm -rf build src

mv SDL2_mixer-2.0.1 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=$X_DISTRO_BASE/dest --disable-shared || fail_with SDL_mixer 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-s -O3" || fail_with SDL_mixer 2 - EPIC FAIL
make install || fail_with SDL_mixer 3 - EPIC FAIL
cd $X_DISTRO_BASE
rm -rf build src

mv vorbis-tools-1.4.0 src
mkdir build
cd build

../src/configure --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 \
--prefix=$X_DISTRO_BASE/dest --disable-nls || fail_with vorbis-tools 1 - EPIC FAIL

make $X_MAKE_JOBS all "CFLAGS=-s -O3" || fail_with vorbis-tools 2 - EPIC FAIL
make install || fail_with vorbis-tools 3 - EPIC FAIL
cd $X_DISTRO_BASE
rm -rf build src

mv dest SDL+libogg+libvorbis+SDL_mixer+vorbis-tools
cd SDL+libogg+libvorbis+SDL_mixer+vorbis-tools
rm -rf bin/sdl2-config lib/cmake lib/pkgconfig lib/*.la share
for i in bin/*.exe; do mv $i ${i/x86_64-w64-mingw32-}; done

7z -mx0 a ../SDL+libogg+libvorbis+SDL_mixer+vorbis-tools.7z *
