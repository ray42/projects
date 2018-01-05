#!/bin/bash


rm -rf GITREMOTES
touch GITREMOTES
for d in */ ; do
  cd $d
  gitremote=$(git config --get remote.origin.url)
  cd ..
  echo "$gitremote" >> GITREMOTES
done


