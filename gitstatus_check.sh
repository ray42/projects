#!/bin/bash

## Top level dir
TOPDIR=`pwd`


## First check the arguments list
ATTEN_ONLY=true
AA=$1

# set -a for attention only
if [ "$AA" == "-a" ]; then
  ATTEN_ONLY=false
fi

############################################################################
############################################################################
############################################################################
## Get list of top level dirs and private dirs
#https://stackoverflow.com/questions/4494336/how-do-you-store-a-list-of-directories-into-an-array-in-bash-and-then-print-the

declare -a GITDIRS
count=0
#result=${PWD##*/}
for dir in */ ; do
  GITDIRS[${count}]=${dir}
  count=$((count+1))

  cd ${dir}
  if [ -d *Private ] ; then
    # Remove slash at the end of dir
    GITDIRS[${count}]="${dir}${dir%/}Private/"
    count=$((count+1))
  fi
  cd ${TOPDIR}
done

############################################################################
############################################################################
############################################################################

TOTALNDIR=0;
CLEANNDIR=0;
TOPUSHNDIR=0;
ATTENTIONNDIR=0;
NOGITNDIR=0;
NOREMOTENDIR=0;

for dir in "${GITDIRS[@]}" ; do

cd ${dir}

VAR=""
if [ -d ".git" ]; then
  VAR="$(git status 2>&1)"
else
  VAR="RAYRAY: no git directory"
fi

## Check if git directory exists
if [[ $VAR == *"RAYRAY: no git directory"* ]]
then
  # \e[0m resets all font
  echo -e "\e[0m\n"

  # 31 is red
  #1 is bold
  #21 resets the bold
  echo -e "\e[1;31m$dir"
  echo -e "\e[21;31mNot a git repo"

  NOGITNDIR=$((NOGITNDIR+1))

elif [[ $VAR != *"origin/master"* ]]
then
  # \e[0m resets all font
  echo -e "\e[0m\n"

  # 31 is red
  #1 is bold
  #21 resets the bold
  echo -e "\e[1;31m$dir"
  echo -e "\e[21;31mRemote not set"

  NOREMOTENDIR=$((NOREMOTENDIR+1))


## Check if anything needs pushing to repo.
elif [[ $VAR == *"Your branch is ahead"* ]]
then
  # \e[0m resets all font
  echo -e "\e[0m\n"

  # 33 is yellow
  #1 is bold
  #21 resets the bold
  echo -e "\e[1;33m$dir"
  echo -e "\e[21;33m${VAR}"

  TOPUSHNDIR=$((TOPUSHNDIR+1))


## Now check if everything is okay.
elif [[ $VAR == *"nothing to commit, working tree clean"* ]]
then

  ## Check if we need to show this.
  if [ "$ATTEN_ONLY" = false ] ; then
    # \e[0m resets all font
    echo -e "\e[0m\n"

    # 32 is green
    #1 is bold
    #21 resets the bold
    echo -e "\e[1;32m$dir"
    echo -e "\e[21;32m${VAR}"
  fi

  CLEANNDIR=$((CLEANNDIR+1))

## Everything else needs my attention
else
  # \e[0m resets all font
  echo -e "\e[0m\n"

  # 31 is red
  #1 is bold
  #21 resets the bold
  echo -e "\e[1;31m$dir"
  echo -e "\e[21;31m${VAR}"

  ATTENTIONNDIR=$((ATTENTIONNDIR+1))
fi

TOTALNDIR=$((TOTALNDIR+1))
cd ${TOPDIR}
done

############################################################################
############################################################################
############################################################################

# \e[0m resets all font
echo -e "\e[0m\n"
echo "Total dirs: ${TOTALNDIR}"

if [ "$CLEANNDIR" -ne 0 ]; then
  echo -e "\e[21;32m#clean: ${CLEANNDIR}"
fi

if [ "$TOPUSHNDIR" -ne 0 ]; then
  echo -e "\e[21;33m#To push: ${TOPUSHNDIR}"
fi

if [ "$ATTENTIONNDIR" -ne 0 ]; then
  echo -e "\e[21;31m#Attention: ${ATTENTIONNDIR}"
fi

if [ "$NOREMOTENDIR" -ne 0 ]; then
  echo -e "\e[21;31m#No remote: ${NOREMOTENDIR}"
fi

if [ "$NOGITNDIR" -ne 0 ]; then
  echo -e "\e[21;31m#No Git dir: ${NOGITNDIR}"
fi



