which nasm >/dev/null || { echo "you need nasm 2.07+"; exit 1; }

ver=1.3.0

file=libjpeg-turbo-$ver
[ -f $file.tar.gz ] || wget http://downloads.sourceforge.net/project/libjpeg-turbo/$ver/$file.tar.gz
[ -d $file ] || tar xvf $file.tar.gz
cd $file

./configure --host x86_64-apple-darwin NASM=/opt/local/bin/nasm
make clean
make

cp -f ".libs/$(readlink .libs/libjpeg.dylib)" ../../../bin/osx64/libjpeg.dylib
cd ..

rm -Rf $file
rm -f $file.tar.gz
