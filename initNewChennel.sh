#!/bin/bash
# arg example: 000315        a1501f815598a9d    E948A613-6231-1134-1E71-54D31A048FE3    A8919AD0F905E49ED47644AFF1F06FD7A    hengXin    40010036  

echo $1
echo $2
echo $3
echo $4
echo $5
echo $6

vim -c %s/MC099474/$6 -c wq AndroidManifest.xml
vim -c g/android:debuggable/s/true/false -c wq AndroidManifest.xml

vim -c g/999999/s//$1 -c wq ant.properties
vim -c g/_testChannel/s//_$5 -c wq ant.properties

vim -c g/999999/s//$1 -c wq .project

vim -c g/999999/s//$1 -c wq ./jni/ModuleCustom_android.h

vim -c g/a1507f7080c3fe7/s//$2 -c wq ./src/org/cocos2dx/FishingJoy2/FishingJoy2.java
vim -c g/A8FEB248B537.*A3E/s//$3 -c wq ./src/org/cocos2dx/FishingJoy2/FishingJoy2.java
vim -c g/0815695621.*A180/s//$4 -c wq ./src/org/cocos2dx/FishingJoy2/FishingJoy2.java

vim -c g/setOutputLogEnable/s/true/false -c wq ./src/org/cocos2dx/FishingJoy2/FishingJoy2.java
