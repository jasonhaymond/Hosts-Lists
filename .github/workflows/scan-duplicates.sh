#!/bin/bash

for list in $(find . -name "*.txt")
do
  sort "$list" | uniq -u
done
