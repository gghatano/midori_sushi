#!/bin/bash

dir=$(dirname $0)

num=0
cat $dir/url.list | while read url 
do
  num=$(($num+1))
  nowTime=$(date +%Y%m%d%H%M%S)
  curl $url >$dir/htmls/${nowTime}_${num}.html 2>/dev/null
done

