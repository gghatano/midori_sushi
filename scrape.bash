#!/bin/bash

## parse the $dir/htmls/html files

## create data table 
## TIME,PLACE,WAITING

dir=$(dirname $0)

for file in `ls htmls`
do
  echo $file
  YEAR=$(echo $file | cut -c 1,2,3,4)
  DATE=$(echo $file | cut -c 5,6,7,8)
  TIME=$(echo $file | cut -c 9,10,11,12)

  PLACE=$(cat $dir/htmls/$file | 
  grep -A 2 "h1_title" |
  tr -d "\n" | 
  sed -e 's/<[^>]*>//g' -e 's/　/ /g' | 
  awk -F" ｜" '{print $1}' | 
  sed -e 's/ /_/g' -e 's/^__*//g')

  WAITING=$(cat $dir/htmls/$file | 
  grep -A 2 "<strong>ただいまの待ち状況" | 
  tr -d "\n" | 
  sed -e 's/[ ]//g' -e 's/<[^>]*>//g' -e 's/　/,/g' | 
  awk -F, '{print $2}' | 
  grep -o -E "[0-9]+")
  echo $YEAR,$DATE,$TIME,$PLACE,$WAITING
  #echo $PLACE
done
