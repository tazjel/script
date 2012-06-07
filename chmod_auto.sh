#!/bin/bash  
typeset aa=`ls -l aFile.txt|awk '{print substr($1, 2)}'|sed 's/-/0/g'|sed 's/r/1/g'|sed 's/w/1/g'|sed 's/x/1/g'`
typeset bb=$(echo "obase=8;ibase=2;$aa"|bc)

echo $bb
