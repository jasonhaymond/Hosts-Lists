#!bin/bash

for list in *.list
do
  sort $list | uniq -u
done
