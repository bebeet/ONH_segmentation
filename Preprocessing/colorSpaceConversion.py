
import cv2
import numpy as np
from matplotlib import pyplot as plt
import glob



def HE_color(input_path,output_path):
    img = cv2.imread(input_path)

    img_trans = cv2.cvtColor(img, cv2.COLOR_RGB2LAB)
    print(np.matrix(img_trans[:, :, 2]).min())
    #cv2.imwrite(output_path,img_trans)

impath ="../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe/"
outpath = "../Dataset/RIM_ONE_r1/All_Resize/10/equalized_l_clahe_CIELAB/"
imgList = glob.glob(impath+"*.jpg")
for img in imgList:
    fname = img.split('/')[6]
    fname = fname.split('.')[0]
    output_dir = outpath+fname+".jpg"
    HE_color(img,output_dir)
    print img











