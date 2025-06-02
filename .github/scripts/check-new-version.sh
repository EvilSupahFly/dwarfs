#!/bin/bash
set -e

# Fetch latest tag from upstream
UPSTREAM_REPO="https://github.com/mhx/dwarfs.git"
LATEST_TAG=$(git ls-remote --tags "$UPSTREAM_REPO" | grep -o 'refs/tags/[^{}]*$' | sed 's/refs\/tags\///' | sort -V | tail -n1)

# Get last built version from the tracked file (if exists)
LAST_BUILT_TAG=$(cat .latest-version 2>/dev/null || echo "")

echo "Latest upstream tag: $LATEST_TAG"
echo "Last built tag: $LAST_BUILT_TAG"

# If different, save new version and exit 0 (continue workflow)
if [ "$LATEST_TAG" != "$LAST_BUILT_TAG" ]; then
    echo "$LATEST_TAG" > .latest-version
    echo "::set-output name=should_build::true"
else
    echo "::set-output name=should_build::false"
fi
