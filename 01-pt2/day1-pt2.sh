#!/usr/bin/env bash

module_fuel() {
    echo $(( $1 / 3 - 2 ))
}

total=0
while read -r weight; do
    this_module=$(module_fuel "$weight")
    while [[ this_module -gt 0 ]]; do
        (( total += this_module ))
        this_module=$(module_fuel "$this_module")
    done
done

echo "$total"