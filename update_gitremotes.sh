#!/bin/bash


rm -rf GITREMOTES.ray
touch GITREMOTES.ray
for d in */ ; do
  cd $d
  gitremote=$(git config --get remote.origin.url)
  cd ..
  echo "$gitremote" >> GITREMOTES.ray
done


