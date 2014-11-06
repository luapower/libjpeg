./get-it.sh
cd src
cmake -G "MSYS Makefiles" .
make clean
make jpeg-static
cp -f libjpeg.a ../../../bin/mingw64/static/jpeg.a
make clean
