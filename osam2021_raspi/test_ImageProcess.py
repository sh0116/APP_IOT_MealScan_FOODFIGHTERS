import cv2
import sys
import numpy as np
import os
import math
from skimage.feature import peak_local_max
from skimage.morphology import watershed
from scipy import ndimage
import imutils
from src import utill
import glob

class Image_Processing:
	def __init__(self):
		self.per_list = ["70_per","50_per","30_per","0_per"]
		self.dish_tag = ["_side_1","_side_2","_side_3","_rice","_soup"]
		self.DataList = list()


		for self.per in self.per_list:
			for self.tag in self.dish_tag:
				print("{}{}.png".format(self.per,self.tag))
				print(self.backProjection())


	# backProjection Function
	def backProjection(self):
		img = cv2.imread('asset/test_image/100_per/100_per{}.png'.format(self.tag), cv2.IMREAD_COLOR)
		hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
		#print("asset/test_image/{}/{}{}.png".format(self.per,self.per,self.tag))
		imgs = cv2.imread("asset/test_image/{}/{}{}.png".format(self.per,self.per,self.tag), cv2.IMREAD_COLOR)
		hsvt = cv2.cvtColor(imgs, cv2.COLOR_BGR2HSV)

		roihist = cv2.calcHist([hsv],[0,1],None,[180,256],[0,180,0,256]) 
		cv2.normalize(roihist,roihist,0,255,cv2.NORM_MINMAX) 
		dst = cv2.calcBackProject([hsvt],[0,1],roihist,[0,180,0,256],1) 
		
		disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(5,5)) 
		cv2.filter2D(dst,-1,disc,dst) 
		
		thr = cv2.threshold(dst,50,255,0)[1]
		thr = cv2.merge((thr,thr,thr)) 
		res = cv2.bitwise_and(imgs,thr)
		#cv2.imwrite('result{}.png'.format(self.cnt), res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]])
		return self.processLog(res)
   
   
	def processLog(self,images):
		imnp = np.array(images)
		h, w = imnp.shape[:2]
		colours, counts = np.unique(imnp.reshape(-1,3), axis=0, return_counts=1)

		count = counts[0]
		proportion = (100 * count) / (h * w)
		colour = [0,0,0]
		return 100.0 - proportion
if __name__=="__main__":
	Image_Processing()


