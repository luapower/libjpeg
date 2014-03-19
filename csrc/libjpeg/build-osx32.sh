./get-it.sh
cd src
./configure --host i686-apple-darwin NASM=/opt/local/bin/nasm \
    CFLAGS="-O3 -m32 -mmacosx-version-min=10.4" LDFLAGS="-m32 -mmacosx-version-min=10.4"
make clean
make
cp -f ".libs/$(readlink .libs/libjpeg.dylib)" ../../../bin/osx32/libjpeg.dylib
make clean
