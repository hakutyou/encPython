#!/bin/sh
# Run it in docker container only
wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz
tar xf Python-3.6.5.tgz

apt-get install libssl-dev zlib1g-dev -y

# Patch
for i in `find * -regex '^Python-3\.6\.5ht[0-9]+\.patch$'`; do
    cd Python-3.6.5
    patch -p1 < ../$i
    cd ..
done

# Compile
cd Python-3.6.5
mkdir usr -p
./configure --prefix=/app/usr --enable-optimizations
make && make install
cd ..

for i in `find /app/usr -type d -name __pycache__`; do
	rm -rf $i
done

for i in `find /app/usr -type f`; do
	strip $i
done

# Clean
#rm Python-3.6.5 -r

