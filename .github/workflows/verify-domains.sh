#!/bin/bash

for file in *.txt
do
  for domain in file
  do
    ping -c 1 "$domain" > /dev/null
    if [ ! $? -eq 0 ]
    then
      echo "Domain $domain is unavailable. Commenting out the line."
      sed -i s/^/# /' "$2"
    fi
  done
done
