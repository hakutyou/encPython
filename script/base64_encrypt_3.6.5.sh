#!/bin/sh

if [ $# != 1 ] ; then
        echo "USAGE: $0 project_folder"
        exit -1
fi

mkdir -p "$1_encrypt"

for i in `find $1 -regex .*\.py`; do
        base64 $i | sed "1s/^/\&/"> `echo $i|sed "s/$1/$1_encrypt/"`
done

