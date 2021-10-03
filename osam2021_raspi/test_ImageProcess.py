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
		self.dish_tag = ["_side_1","_side_2","_side_3","_soup","_rice"]
		self.DataList = list()


		for self.per in self.per_list:
			print("{} : result ".format(self.per))
			print(" side_1 | side_2 | side_3 |  soup  |  rice  |")
			for self.tag in self.dish_tag:
				#print("{}{}.png".format(self.per,self.tag))
				print( " {:.2f}  |".format(float(self.backProjection())) ,end="") 
			print("\n")


	# backProjection Function
	def backProjection(self):
		img = cv2.imread('asset/test_image/100_per/100_per{}.png'.format(self.tag), cv2.IMREAD_COLOR)
		hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
		imgs = cv2.imread("asset/test_image/{}/{}{}.png".format(self.per,self.per,self.tag), cv2.IMREAD_COLOR)
		hsvt = cv2.cvtColor(imgs, cv2.COLOR_BGR2HSV)

		if self.tag == "_rice":
			roihist = cv2.calcHist([hsv],[0,1],None,[200,256],[0,200,0,256]) 
			nomal_roihist = cv2.normalize(cv2.log(roihist+2),roihist,0,255,cv2.NORM_MINMAX,cv2.CV_8U)
			dst = cv2.calcBackProject([hsvt],[0,1],nomal_roihist,[0,200,0,256],1) 
		else:
			roihist = cv2.calcHist([hsv],[0,1],None,[180,256],[0,180,0,256]) 
			nomal_roihist = cv2.normalize(roihist,roihist,0,255,cv2.NORM_MINMAX)
			dst = cv2.calcBackProject([hsvt],[0,1],nomal_roihist,[0,180,0,256],1)  
		#cv2.normalize(roihist,roihist,0,255,cv2.NORM_MINMAX) 
		#dst = cv2.calcBackProject([hsvt],[0,1],nomal_roihist,[0,180,0,256],1) 

		if self.tag == "_rice":
			disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(10,10)) 
		else:
			disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(5,5)) 

		cv2.filter2D(dst,-1,disc,dst) 
		
		thr = cv2.threshold(dst,50,255,0)[1]
		thr = cv2.merge((thr,thr,thr)) 
		res = cv2.bitwise_and(imgs,thr)
		cv2.imwrite('asset/result_test_image/result_{}{}.png'.format(self.per,self.tag), res)
		
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


