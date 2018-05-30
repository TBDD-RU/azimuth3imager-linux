#!/bin/bash

dd if=/dev/urandom of=noise bs=64 count=12 2> /dev/null

tar cfj noise.tar.bz2 noise
