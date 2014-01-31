which nasm  >/dev/null || { echo "you need nasm"; exit 1; }
which cmake >/dev/null || { echo "you need cmake"; exit 1; }

ver=1.3.0

file=libjpeg-turbo-$ver
[ -f $file.tar.gz ] || {
	which wget >/dev/null || { echo "you need wget"; exit 1; }
	wget http://downloads.sourceforge.net/project/libjpeg-turbo/$ver/$file.tar.gz
}
[ -d $file ] || tar xvfz $file.tar.gz
cd $file

cmake -G "MSYS Makefiles" .
make clean
make jpeg
strip sharedlib/libjpeg-62.dll
cp sharedlib/libjpeg-62.dll ../../../bin/mingw32/jpeg.dll

cd ..
rm -Rf $file
rm $file.tar.gz
