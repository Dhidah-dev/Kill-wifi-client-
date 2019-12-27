#!/bin/bash
. ../../config.cfg
pwd 
if [ $# -eq 0 ]
	then	
	echo set argument file_mng_64 or Cube_Prog_64 or file_mng_32 or Cube_Prog_32 or KeyGen_64 or KeyGen_32 or SigningTool_32 or SigningTool_64 or Trust_32 or Trust_64
fi 
if [ "$1" == file_mng_64 ] ; then
	path_is=$prog_path_FM_64
fi
if [ "$1" == file_mng_32 ] ; then
	path_is=$prog_path_FM_32
fi
if [ "$1" == Cube_Prog_64 ] ; then
	path_is=$prog_path_CP_32
fi
if [ "$1" == Cube_Prog_32 ] ; then
	path_is=$prog_path_CP_32
fi

if [ "$1" == KeyGen_64 ] ; then
	path_is=$prog_path_keygen_64
fi

if [ "$1" == KeyGen_32 ] ; then
	path_is=$prog_path_keygen_32
fi

if [ "$1" == SigningTool_32 ] ; then
	path_is=$prog_path_SigningTool_32
fi

if [ "$1" == SigningTool_64 ] ; then
	path_is=$prog_path_SigningTool_64
fi

if [ "$1" == Trust_32 ] ; then
	path_is=$prog_path_Trust_32
fi

if [ "$1" == Trust_64 ] ; then
	path_is=$prog_path_Trust_64
fi


cd $path_is
pwd
branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}
echo $branch_name
if [ $branch_name == develop ]; then
	echo "im in develop"
	git pull origin develop
else
	echo "i'm not in develop "
	git checkout develop
	git pull origin develop
	branch_name=$(git symbolic-ref -q HEAD)
	branch_name=${branch_name##refs/heads/}
	branch_name=${branch_name:-HEAD}
	echo $branch_name
fi 
