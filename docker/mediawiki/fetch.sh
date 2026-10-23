#!/bin/sh

set -e

type=$1
name=$2
version=$MW_VERSION

# extdist only serves supported branches (REL1_41 is gone), so use the GitHub mirrors
dir=mediawiki/${type}s/$name
mkdir -p $dir
curl -fsL "https://github.com/wikimedia/mediawiki-${type}s-$name/archive/refs/heads/$version.tar.gz" \
  | tar xz -C $dir --strip-components=1
