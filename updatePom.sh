#!/bin/bash
set -e
updatePom() {
	find . -name pom.xml | while read pom
	do
		if grep "$1" $pom >/dev/null 2>&1
		then
			echo $pom
			sed "s/$1/$2/g" <$pom >$pom.new
			mv $pom.new $pom
		fi
	done
}
if [ "$1" != "" ]
then
  release=$1
  if [ "$2" != "" ]
  then
     nextRelease=$2
  else
  	next=$version
  fi
fi
echo "release="$release
echo "next="$nextRelease

updatePom $release $nextRelease