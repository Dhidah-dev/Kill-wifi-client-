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
#
# create the non snapshot release in microxplorer
#
#
# first compile a first time with all plugins to be able to regenerate mcu db
#
# Cleanup Workspace 

cd "$top"
git status | grep -v pom.xml

#
# commit all the changes
#
cd "$top"
git commit -a -m "Version $release"
if `git tag | grep $release`
then
	#
	# tag already exist, remove it
	#
	git tag -d microxplorer-$release
	git push origin :refs/tags/microxplorer-$release
fi
#
# create a tag for the release
#
git tag microxplorer-$release
#
# prepare for the next version
#
updatePom $release $next
#
# commit all the new pom
#
git commit -a -m "Version $next"
#
# push the created tag
#
git push origin microxplorer-$release
#
# and push the pom files
#
branch=`git branch | grep "*" | awk '{print $2}'`
git push -v --progress  "origin" $branch:$branch

exit 0
