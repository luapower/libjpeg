which nasm >/dev/null || { echo "you need nasm"; exit 1; }

ver=1.3.0

file=libjpeg-turbo-$ver
[ -f $file.tar.gz ] || wget http://downloads.sourceforge.net/project/libjpeg-turbo/$ver/$file.tar.gz
[ -d $file ] || tar xvf $file.tar.gz
cd $file

./configure
make clean
make

cp -f ".libs/$(readlink .libs/libjpeg.so)" ../../../bin/linux32/libjpeg.so
cd ..

rm -Rf $file
rm -f $file.tar.gz
