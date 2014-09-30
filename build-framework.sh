#!/bin/sh
set -e

#adapted from http://www.raywenderlich.com/65964/create-a-framework-for-ios

PRODUCT_NAME="openssl"

export FRAMEWORK_LOCN="${PRODUCT_NAME}.framework"
 
# Create the path to the real Headers die
mkdir -p "${FRAMEWORK_LOCN}/Versions/A/Headers"
 
# Create the required symlinks
/bin/ln -sfh A "${FRAMEWORK_LOCN}/Versions/Current"
/bin/ln -sfh Versions/Current/Headers "${FRAMEWORK_LOCN}/Headers"
/bin/ln -sfh "Versions/Current/${PRODUCT_NAME}" \
                 "${FRAMEWORK_LOCN}/${PRODUCT_NAME}"
 
# Copy the public headers into the framework
/bin/cp -a "include/" "${FRAMEWORK_LOCN}/Versions/A/Headers"

# Combine the static libs into the framework binary
libtool -static -o "${FRAMEWORK_LOCN}/Versions/A/${PRODUCT_NAME}" lib/*
