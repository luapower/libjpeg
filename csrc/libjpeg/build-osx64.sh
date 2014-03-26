./get-it.sh
cd src
./configure --host x86_64-apple-darwin NASM=/opt/local/bin/nasm \
    CFLAGS="-O3 -m64 -mmacosx-version-min=10.6" LDFLAGS="-m64 -mmacosx-version-min=10.6"
make clean
make
cp -f ".libs/$(readlink .libs/libjpeg.dylib)" ../../../bin/osx64/libjpeg.dylib
install_name_tool -id @loader_path/libjpeg.dylib ../../../bin/osx64/libjpeg.dylib
make clean
