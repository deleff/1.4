#!/bin/bash


echo "Enter major version"
read major

echo "Enter minor version"
read minor

version=$major.$minor
branch_name="release/$version"


echo "Checking for branch $branch_name"

if [ `git branch --list $branch_name `]
then
   echo "Branch name $branch_name already exists."

   tag=`git describe --tags`
   echo "last tag was $tag"

else
   echo "creating branch $branch_name"
   git checkout -b $branch_name
fi

#git push -u origin $branch_name


