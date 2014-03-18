./get-it.sh
cd src
./configure --host x86_64-apple-darwin NASM=/opt/local/bin/nasm
make clean
make
cp -f ".libs/$(readlink .libs/libjpeg.dylib)" ../../../bin/osx64/libjpeg.dylib
