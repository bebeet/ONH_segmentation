
import cv2
import numpy as np
from matplotlib import pyplot as plt
import glob


def HE(imname,impath):
    img = cv2.imread(imname,0)
    equ = cv2.equalizeHist(img)
    cv2.imwrite(impath, equ)

impath ="../Dataset/RIM_ONE_r1/All_Resize/10/original_gray/"
outpath = "../Dataset/RIM_ONE_r1/All_Resize/10/GHE/gray/"
imgList = glob.glob(impath+"*.jpg")

size = np.arange(1,10)
for img in imgList:
    fname = img.split('/')[6]
    fname = fname.split('.')[0]
    print img
    input_dir = impath+fname+".jpg"
    output_dir = outpath+fname+".jpg"
    HE(input_dir,output_dir)



