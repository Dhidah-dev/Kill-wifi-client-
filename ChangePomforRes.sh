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

#
# first make sure to be at the top of the GIT tree
#
cd MicroXplorer
top=`git rev-parse --show-toplevel`
echo $top
if [ $? -ne 0 ]
then
  exit 1
fi
cd "$top"
version=`grep "<version>" microxplorer/pom.xml | head -1 | sed "s/[ \t]*<version>//;s/<.*//"`
cur=`echo $version | sed "s/-SNAPSHOT//;s/.*[^0-9]//"`
prefix=`echo $version | sed "s/-SNAPSHOT//;s/[0-9]*$//"`
#
# if a parameter is passed it is the version to generate
# in that case, we won't change the current snapshot version
# we'll just generate a special version
#
if [ "$1" != "" ]
then
  release=$1
  if [ "$2" != "" ]
  then
     next=$2
  else
  	next=$version
  fi
else
  release=$prefix$cur
  cur=$(($cur+1))
  next=$prefix$cur-SNAPSHOT
fi
echo "version="$version
echo "release="$release
echo "next="$next

#
# update all the pom files with the correct release
#
updatePom $version $release

exit 0
