#!/bin/bash

#declare -a arr=("git@gitlab.com:rayaxiom/cpp_primer_5ed.git" 
#                "git@gitlab.com:rayaxiom/IntroductionToAlgorithms_3ed_2009.git"
#                "git@gitlab.com:rayaxiom/accelerated_cpp.git"
#                "git@gitlab.com:rayaxiom/raycppnotes.git"
#                "git@gitlab.com:rayaxiom/more_exceptional_cpp_1ed_2001.git"
#                "git@gitlab.com:rayaxiom/exceptional_cpp_style_1ed_2004.git"
#                "git@gitlab.com:rayaxiom/exceptional_cpp_1ed_1999.git"
#                "git@gitlab.com:rayaxiom/effective_cpp_3ed.git"
#                "git@gitlab.com:rayaxiom/the_cpp_programming_language_4ed.git"
#                "git@gitlab.com:rayaxiom/sicp.git"
#                "git@gitlab.com:rayaxiom/project_euler.git"
#                "git@gitlab.com:rayaxiom/hackingvim2010.git")

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
    cd ..
  else
    git clone $line;
  fi
  
  #printf '%s\n' "${tmp%.git}"
done < GITREMOTES

