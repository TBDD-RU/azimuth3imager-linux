#!/bin/bash

mkdir -p build

c++ -std=c++11 src/a3i_getsize.cpp -o build/a3i-getsize -l boost_iostreams
c++ -std=c++11 src/a3i_extract.cpp -o build/a3i-extract -l boost_iostreams
