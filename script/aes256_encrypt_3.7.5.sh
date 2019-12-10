#!/bin/sh

if [ $# != 2 ] ; then
        echo "USAGE: $0 project_folder password"
        exit -1
fi

for i in `find $1 -regex .*\.py`; do
        cp "$i" "$i.orig"
        sed -i "1s/^/*/" "$i"
        gpg --symmetric --batch --yes --passphrase "$2" $i
        # 替换原文件
        mv "$i.gpg" "$i"
        sed -i "1s/^/*/" "$i"
done
