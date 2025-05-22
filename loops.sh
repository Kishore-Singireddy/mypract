#!/bin/bash

#Loops Practice

for i in {1..20}
do 
    echo "$i"
done

myfav=("UM" "SL" "SV" "MD" "MG")

for i in ${myfav[@]}
do 
    echo "$i"
done
