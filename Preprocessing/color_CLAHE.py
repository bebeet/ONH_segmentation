import cv2
import numpy as np
from matplotlib import pyplot as plt
import glob


def HE_color(input_path,output_path):
    img = cv2.imread(input_path)
    img_yuv =img
    img_yuv = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)


    clahe = cv2.createCLAHE(clipLimit=3,tileGridSize=(3, 3))
    #img_yuv[:, :, 1] = clahe.apply(img_yuv[:, :, 1])
    img_yuv[:, :, 0] = clahe.apply(img_yuv[:, :, 0])

    img_yuv = cv2.cvtColor(img_yuv, cv2.COLOR_LAB2BGR)
    cv2.imwrite(output_path,img_yuv)

impath ="../Dataset/RIM_ONE_r1/All_Resize/100/colorImg/"
outpath = "../Dataset/RIM_ONE_r1/All_Resize/100/equalized_l_clahe/"
imgList = glob.glob(impath+"*.jpg")
for img in imgList:
    fname = img.split('/')[6]
    fname = fname.split('.')[0]
    output_dir = outpath+fname+".jpg"
    HE_color(img,output_dir)
    print img



