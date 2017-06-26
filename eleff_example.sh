#!/bin/bash


echo "Enter major version"
read major

echo "Enter minor version"
read minor

version=$major.$minor
branch_name="$version"


echo "Checking for branch $branch_name"

if  git ls-remote https://github.com/deleff/$branch_name ;
then
   echo "Branch name $branch_name already exists."

#   tag=`git describe --tags`
   echo "last tag was `git describe --abbrev=0 --tags ` "

else
   echo "creating branch $branch_name"
#   git checkout -b $branch_name
fi

#git push -u origin $branch_name


