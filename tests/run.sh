#!/bin/bash

cd tests

./gen-noise.sh

size=$( stat --printf="%s" noise )
size_a3i=$( ../build/a3i-getsize noise.tar.bz2 )

if [ "$size" != "$size_a3i" ]; then
    echo "noise file size doesn't match"
fi

ulimit -f 20

../build/a3i-extract noise.tar.bz2 noise_a3i > /dev/null

hash=$( md5sum -b noise | cut -f 1 -d ' ' )
hash_a3i=$( md5sum -b noise_a3i | cut -f 1 -d ' ' )

if [ "$hash" != "$hash_a3i" ]; then
    echo "hash doesn't match"
fi

cd ..
