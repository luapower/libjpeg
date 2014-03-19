./get-it.sh
cd src
./configure --host x86_64-apple-darwin NASM=/opt/local/bin/nasm \
    CFLAGS="-O3 -m64 -mmacosx-version-min=10.4" LDFLAGS="-m64 -mmacosx-version-min=10.4"
make clean
make
cp -f ".libs/$(readlink .libs/libjpeg.dylib)" ../../../bin/osx64/libjpeg.dylib
make clean
