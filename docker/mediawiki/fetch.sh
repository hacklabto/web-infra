#!/bin/sh

type=$1
name=$2
version=$MW_VERSION

function fetch_extension {
  url=$(curl "https://www.mediawiki.org/w/api.php?action=query&list=extdistbranches&format=json&edbexts=$name" | jq -r ".query.extdistbranches.extensions.$name.$version")

  (cd mediawiki/extensions && curl $url | tar xz)
}

function fetch_skin {
  url=$(curl "https://www.mediawiki.org/w/api.php?action=query&list=extdistbranches&format=json&edbskins=$name" | jq -r ".query.extdistbranches.skins.$name.$version")

  (cd mediawiki/extensions && curl $url | tar xz)
}

`fetch_$type`
