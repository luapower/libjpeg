./get-it.sh
cd src
./configure
make clean
make
cp -f ".libs/$(readlink .libs/libjpeg.so)" ../../../bin/linux32/libjpeg.so
make clean
