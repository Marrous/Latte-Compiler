#!/bin/bash
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
Off='\033[0m'             # Text Reset

for f in $(find tests/ -type f ! -name "*.*"); do
    OUT_NAME=$f.output
    MY_OUT=($f.my_output)
    if [ -e $f.input ];
    then
        $f < $f.input > $MY_OUT
    else
        $f > $MY_OUT
    fi
    DIFF=$(diff $MY_OUT $OUT_NAME)
    if [ "$DIFF" != "" ]
    then
        echo -e "$Off $BRed Test failed:  $OUT_NAME $Off"
    else
        echo -e "$Off $BGreen Test passed:  $OUT_NAME $Off"
    fi
done
