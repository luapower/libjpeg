./get-it.sh
cd src
cmake -G "MSYS Makefiles" .
make clean
make jpeg
strip sharedlib/libjpeg-62.dll
cp sharedlib/libjpeg-62.dll ../../../bin/mingw64/jpeg.dll
make clean
