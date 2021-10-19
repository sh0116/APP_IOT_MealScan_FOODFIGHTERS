# Run in Jupyter Notebook!

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

# image process class
class Image_Processing:
	def __init__(self, image):
		# get image from main_process
		self.image = cv2.imread(image)
		self.images = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
		self.image_lenght_x,self.image_lenght_y,_ =  self.image.shape

		dish = list()
		
		# split image (x,y)point
		rect_range = [[230,405,155,315],[35,220,155,315],[35,160,35,145],[175,270,35,145],[285,405,35,145]]
		for x1,x2,y1,y2 in rect_range:
			dish.append([[x1,y2],[x1,y1],[x2,y1],[x2,y2]])
		self.side_rect = dish[:3]
		self.main_rect = dish[3:]
		self.dish_tag = ["side_1","side_2","side_3","rice","soup"]
		self.cnt=0
		self.DataList = list()

		# split and backProjection (side)
		for self.box in self.side_rect:
			self.DataList.append(self.backProjection())
			self.cnt+=1	

		# backProjection (main)
		for self.box in self.main_rect:
			self.DataList.append(self.backProjection())
			self.cnt+=1			


	# backProjection Function (역투영)
	def backProjection(self):
		# read image (Region of Interest & Target image)
		img = cv2.imread('/content/APP_IOT_MealScan_FOODFIGHTERS/IoT(Raspberry Pi)/asset/test_image/100_per/100_per_{}.png'.format(self.dish_tag[self.cnt]), cv2.IMREAD_COLOR)
		hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV) 
		hsvt = cv2.cvtColor(self.image, cv2.COLOR_BGR2HSV) 
		
		# calculate Histogram (get histogram info )
		roihist = cv2.calcHist([hsv],[0,1],None,[180,256],[0,180,0,256]) 
		# nomalize image base by histogram info
		cv2.normalize(roihist,roihist,0,255,cv2.NORM_MINMAX) 
		# calc BackProject (역투영)
		dst = cv2.calcBackProject([hsvt],[0,1],roihist,[0,180,0,256],1) 
		
		disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(5,5)) 
		cv2.filter2D(dst,-1,disc,dst) 
		
		# Masking
		thr = cv2.threshold(dst,50,255,0)[1]
		thr = cv2.merge((thr,thr,thr)) 
		res = cv2.bitwise_and(self.image,thr)
		
		# processLog function is count masking(RGB(0,0,0)) area 
		# and calculate ratio
		return utill.processLog(res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]])

if __name__=="__main__":
	# test image is 70per.png
	img_pro = Image_Processing("asset/test_image/70_per/70per.png")


