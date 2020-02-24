#!/usr/bin/env bash

echo "\nContent of / before libunionpreload"
echo "-----------------------------------\n"

ls /

export CURRENT_DIRECTORY="$(dirname "$(readlink -f "${0}")")"
export UNION_PRELOAD="${CURRENT_DIRECTORY}"
export LD_PRELOAD="${CURRENT_DIRECTORY}/libunionpreload.so"

echo "\nContent of / after libunionpreload"
echo "-----------------------------------\n"

ls /

echo
