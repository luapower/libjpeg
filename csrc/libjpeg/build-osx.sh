./get-it.sh
cd src
FLAGS=""
make clean
./configure --host i686-apple-darwin \
	NASM=/opt/local/bin/nasm \
	CFLAGS="-O3 $M -mmacosx-version-min=10.6" \
	LDFLAGS="$M -mmacosx-version-min=10.6"
make
cp -f .libs/libjpeg.dylib ../../../bin/$P/
install_name_tool -id @loader_path/libjpeg.dylib ../../../bin/$P/libjpeg.dylib
cp -f .libs/libjpeg.a ../../../bin/$P/
make clean
