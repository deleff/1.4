#!/bin/bash


#Kodem Kol, enter the code's verion. Then we automate the rest
echo "Enter major version"
read major

echo "Enter minor version"
read minor


#Now test the MVN code

#Default value for build_success, others can be added later for specific errors or successes
build_success="Default value"

mvn install
rc=$?
if [[ $rc -ne 0 ]]
   then
   #If th build is a failure, recourd that in the build_success variable
   build_success="ERROR"  ; 
fi

#Print out the success/failure of the last build
   echo "The maven build ended with: $build_success"

#Begin build-success if statement
if [ $build_success != "ERROR" ]
   then


#version is the major and minor numbers that was entered earlier, the build number will be added to the end of this
version=$major.$minor

#branch name is in the "release" directory
branch_name="$release/version"

#Helpful output
echo "Checking for branch $branch_name"

#Check if branch exists, REMEMBER TO ENTER *YOUR* GITHUB ACCOUNT so we can search for the branch
if  git ls-remote https://github.com/<ENTER_YOUR_ACCOUNT>/$branch_name ;
then
   #Helpful output if branch already exists
   echo "Branch name $branch_name already exists."

   #Get the latest tag, and add 1 to the build (third decimal)
   last_tag=`git describe --abbrev=0 --tags `
   build_num=`echo $last_tag | cut -d. -f3 ` #Last decimal
   build_num=$((build_num+1)) #Add one
   new_tag=${last_tag%.*} #New tag will still have the major and minor numbers of the last tag
   new_tag=$new_tag.$build_num #Place the build number at the end of the tag

   #Helpful output
   echo "The last tag was $last_tag"
   echo "The new tag is $new_tag"


   #Commit (Commit everything?)
   git commit . -m "build $new_tag"
   
   #Add the new tag before committing
   git tag $new_tag

else #New branch else statement
   #Helpful output
   echo "creating branch $branch_name"

   #New tag will have a build number of zero
   new_tag=$version.0

   #Helpful output
   echo "new tag = $new_tag"

   git checkout -b $branch_name
   git checkout $branch_name
   git commit . -m "build $new_tag"

   #Helpful output
   echo "new build = $new_tag"

fi #End new-branch else statement
   
   #push the code to the old or new branch
   git push -u origin $branch_name


fi #end the build-success if statement
