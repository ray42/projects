#!/bin/bash

./update_gitlinks.sh
git add -A
git commit -m "Auto msg: updated GITREMOTES"
git push -u origin master

while IFS= read -r line; do 
  
  folder="${line##*/}" # extract everything except repo.git
  folder="${folder%%.*}"
  
  if [ -d "${folder}" ]
  then
    cd ${folder}
    git push -u origin master
    cd ..
  else
    # 31 is red
    #1 is bold
    #21 resets the bold
    echo -e "\e[1;31m$d"
    echo -e "\e[21;31m${folder} does not exist"
    # \e[0m resets all font
    echo -e "\e[0m\n"
  fi
  
  #printf '%s\n' "${tmp%.git}"
done < GITREMOTES

