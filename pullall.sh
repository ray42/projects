#!/bin/bash

### now loop through the above array
#for i in "${arr[@]}"
#do
#   git clone $i
#done
#
## You can access them using echo "${arr[0]}", "${arr[1]}" also

git pull origin master

while IFS= read -r line; do 
  
  folder="${line##*/}" # extract everything except repo.git
  folder="${folder%%.*}"
  
  if [ -d "${folder}" ]
  then
    cd ${folder}

    git pull origin master

    if [ -d *Private ]; then
      cd *Private
      git pull origin master
      cd ..
    fi

    cd ..
  else
    git clone $line;
    cd ${folder}
    if [ -f pullprivaterepo.sh ]; then
      ./pullprivaterepo.sh
    fi

    cd ..
  fi
  
  #printf '%s\n' "${tmp%.git}"
done < GITREMOTES

