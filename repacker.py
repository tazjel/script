#!/bin/env python
# Usage: unpacker.py <*.plist>

import sys
import os.path
import plistlib
import Image
import re


AssetsDir = r'assets_'
TexutreFileName = ''
Texutre = ''

def boxFromString(box_str):
    res = re.sub('{|}','',box_str)
    out_box = res.split(',')
    out_tuple =  tuple(out_box)
    out_tuple = (int(out_tuple[0]),int(out_tuple[1]),int(out_tuple[2]),int(out_tuple[3]))
    return out_tuple

def sizFromString(size_str):
    res = re.sub('{|}','',size_str)
    out_size = res.split(',')
    out_tuple =  tuple(out_size)
    out_tuple = (int(out_tuple[0]),int(out_tuple[1]))
    return out_tuple


def parseOnePicFormat3(frame_path,pic_info):
    one_pic_frame= boxFromString(pic_info['textureRect'])
    print one_pic_frame

    sourceColorRect = boxFromString(pic_info['spriteColorRect'])
    print sourceColorRect

    org_img = Image.open(frame_path)
    print 'org_img'
    print org_img.size
    to_pate_img = org_img.crop((sourceColorRect[0], sourceColorRect[1], sourceColorRect[0]+sourceColorRect[2], sourceColorRect[1] + sourceColorRect[3]))

    if pic_info['textureRotated'] == True:
        to_pate_img = to_pate_img.transpose(Image.ROTATE_270)
        paste_box = (one_pic_frame[0],one_pic_frame[1],one_pic_frame[0]+one_pic_frame[3],one_pic_frame[1]+one_pic_frame[2])
    else:
        paste_box = (one_pic_frame[0],one_pic_frame[1],one_pic_frame[0]+one_pic_frame[2],one_pic_frame[1]+one_pic_frame[3])
        pass

    print 'paste_box'
    print paste_box
    print 'to_pate_img size'
    print to_pate_img.size
    print 'texture size'
    print Texutre.size
    Texutre.paste(to_pate_img, paste_box)

def parseOnePicFormat1or2(frame_path,pic_info):
    one_pic_frame= boxFromString(pic_info['frame'])
    print one_pic_frame

    sourceColorRect = boxFromString(pic_info['sourceColorRect'])
    print sourceColorRect

    org_img = Image.open(frame_path)
    print 'org_img'
    print org_img.size
    to_pate_img = org_img.crop((sourceColorRect[0], sourceColorRect[1], sourceColorRect[0]+sourceColorRect[2], sourceColorRect[1] + sourceColorRect[3]))

    if pic_info['rotated'] == True:
        to_pate_img = to_pate_img.transpose(Image.ROTATE_270)
        paste_box = (one_pic_frame[0],one_pic_frame[1],one_pic_frame[0]+one_pic_frame[3],one_pic_frame[1]+one_pic_frame[2])
    else:
        paste_box = (one_pic_frame[0],one_pic_frame[1],one_pic_frame[0]+one_pic_frame[2],one_pic_frame[1]+one_pic_frame[3])
        pass

    print 'paste_box'
    print paste_box
    print 'to_pate_img size'
    print to_pate_img.size
    print 'texture size'
    print Texutre.size
    Texutre.paste(to_pate_img, paste_box)



def parsePlist(path):
    plistPath = path
    (dirname, filename) = os.path.split(plistPath)
    (fileBaseName, fileExtension) = os.path.splitext(filename)

    if fileExtension != '.plist':
        print 'Usage: unpacker.py <*.plist>'
        return

    global AssetsDir
    AssetsDir = r'assets_'
    AssetsDir = AssetsDir + fileBaseName + '/'

    if os.path.isdir(AssetsDir) == False:
        os.mkdir(AssetsDir)
        print 'Error, Please puts the assets png into the ' + AssetsDir + '.'
        return

    if os.path.exists(AssetsDir) == False:
        pass
        return

    plist = plistlib.readPlist(filename)
    frames = plist['frames']

    metadata = plist['metadata']

    format = int(metadata['format'])

    global TexutreFileName
    if format == 3:
        target = metadata['target']
        textureFileExtension = target['textureFileExtension']
        TexutreFileName = target['textureFileName'] + textureFileExtension
    else:
        TexutreFileName = metadata['textureFileName']


    print TexutreFileName

    
    texutreSize = sizFromString(metadata['size'])
    print 'texutreSize' 
    print texutreSize
    global Texutre
    Texutre = Image.new('RGBA', texutreSize) 

    pic_names = frames.keys()
    for name in pic_names:
        frame = frames[name]
        frame_full_path =  AssetsDir + name
        if os.path.exists(frame_full_path) == False:
            print 'Error, Lost file ' + frame_full_path + '.'
            return
        print 'Parsing ' + frame_full_path
        if format == 3:
            parseOnePicFormat3(frame_full_path, frame)
        else:
            parseOnePicFormat1or2(frame_full_path, frame)

    Texutre.save(TexutreFileName)
    print 'Saved to ' + TexutreFileName

def main():
    argvs = sys.argv
    if len(argvs) < 2:
        print 'Usage: unpacker.py <*.plist>'
        return

    files = argvs[1:]
    for plist_file in files:
        if os.path.exists(plist_file) == False:
            print 'File ' + plist_file + ' is not exists!'
            return
        print 'Parsing: ' + plist_file
        parsePlist(plist_file)

if __name__ == "__main__":
    main()




