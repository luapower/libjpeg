which nasm  >/dev/null || { echo "you need nasm 2.07+"; exit 1; }

ver=1.3.0
file=libjpeg-turbo-$ver
url=http://downloads.sourceforge.net/project/libjpeg-turbo/$ver/$file.tar.gz

[ -f $file.tar.gz ] || {
	which wget >/dev/null || { echo "you need wget or download $url here"; exit 1; }
	wget $url
}

rm -Rf src
tar xvfz $file.tar.gz
mv $file src
