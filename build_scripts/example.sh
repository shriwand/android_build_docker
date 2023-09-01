#!/bin/bash -e

# Example of custom build script.

readonly DEVICE="${1}"
echo "Dummy customised building ${DEVICE}"

# clean up
rm -rf ${DEVICE}
