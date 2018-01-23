#!/bin/bash

for f in tests/lattests/good/*.lat; do
    ./latc_x86 $f
done

for f in tests/lattests/extensions/arrays1/*.lat; do
    ./latc_x86 $f
done

for f in tests/lattests/extensions/objects1/*.lat; do
    ./latc_x86 $f
done

for f in tests/lattests/extensions/objects2/*.lat; do
    ./latc_x86 $f
done

for f in tests/lattests/extensions/struct/*.lat; do
    ./latc_x86 $f
done

for f in tests/students_tests/good/arrays/*.lat; do
    ./latc_x86 $f
done

for f in tests/students_tests/good/basic/*.lat; do
    ./latc_x86 $f
done

for f in tests/students_tests/gr5/*.lat; do
    ./latc_x86 $f
done
