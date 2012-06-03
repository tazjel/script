#!/usr/bin/env python
#fileName: resizePicture.py
#PIL( Python Imaging Library )
#python resizePicture.py F;\photo F:\photo2  [png, [ 0.5] ]
#from http://www.kgblog.net/2009/09/10/python-resize-picture.html

import Image
import os
import sys

def resizeOne(picFile,outFile,rate):
    picF = Image.open(picFile)
    w,h = picF.size
    w,h = int(w*rate),int(h*rate)
    newF = picF.resize( (w,h) )
    newF.save( outFile )

def main(picPath,newPath,picType,rate):
    fileNames = os.listdir( picPath )
    for file in fileNames:
        dotIx = file.rfind('.')
        fileBegin = file[:dotIx ]
        fileType = file[dotIx+1:]
        if fileType.lower()==picType:
            resizeOne( picPath+'/'+file, 
                newPath+'/'+fileBegin+'_mini.'+fileType, rate )
            print newPath+'/'+fileBegin+'_mini.'+fileType, 'saved'
    
if __name__ == '__main__':
    picPath = sys.argv[1]
    newPath = sys.argv[2]

    picType = 'png'
    if sys.argv[3] != None:
        picType=sys.argv[3]

    rate = 0.5
    if sys.argv[4] != None:
        rate=sys.argv[4]

    if len(sys.argv)>3:
        picType = sys.argv[3]
    if len(sys.argv)>4:
        rate = float( sys.argv[4] )
    if not os.path.isdir(picPath) or not os.path.isdir(newPath):
        print 'The path is incorrect'
        sys.exit()

    print "Scale with : picType=" + picType + ",rate=" + str(rate)
    main(picPath,newPath,picType.lower(),rate )
