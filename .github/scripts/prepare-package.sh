#!/bin/bash
set -e

VERSION="0.12.4"
ARCH="x86_64"
BINARY="dwarfs-universal-${VERSION}-Linux-${ARCH}"
URL="https://github.com/mhx/dwarfs/releases/download/v${VERSION}/${BINARY}"
DEB_DIR="dwarfs-${VERSION}"

# Create directory structure
mkdir -p "${DEB_DIR}/usr/bin"

# Download and decompress the binary
curl -L -o "${BINARY}" "${URL}"
chmod +x "${BINARY}"
upx -d "${BINARY}"

# Move the binary to the package directory
mv "${BINARY}" "${DEB_DIR}/usr/bin/dwarfs"

# Build the .deb package
dpkg-deb --build "${DEB_DIR}"
