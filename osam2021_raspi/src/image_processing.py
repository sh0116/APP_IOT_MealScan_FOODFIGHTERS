import cv2
import sys
import numpy as np
import os
import math
from skimage.feature import peak_local_max
from skimage.morphology import watershed
from scipy import ndimage
import imutils
from src import database
from src import utill

class Image_Processing:
	def __init__(self, image, qr_data):
		self.image = image
		self.images = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
		self.image_lenght_x,self.image_lenght_y,_ =  self.image.shape

		dish = list()
		rect_range = [[245,420,155,260],[60,235,155,260],[60,175,60,145],[185,300,60,145],[310,420,60,145]]
		for x1,x2,y1,y2 in rect_range:
			dish.append([[x1,y2],[x1,y1],[x2,y1],[x2,y2]])
			
		self.dish_tag = ["side_1","side_2","side_3","rice","soup"]
		self.cnt=0
		self.DataList = list()

		for self.box in self.dish:
			self.backProjection()
			self.cnt+=1					
		


	# backProjection Function
	def backProjection(self):
		img = cv2.imread('{}.png'.format(self.dish_tag[self.cnt]), cv2.IMREAD_COLOR)
		hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV) 
		hsvt = cv2.cvtColor(self.image, cv2.COLOR_BGR2HSV) 

		roihist = cv2.calcHist([hsv],[0,1],None,[180,256],[0,180,0,256]) 
		cv2.normalize(roihist,roihist,0,255,cv2.NORM_MINMAX) 
		dst = cv2.calcBackProject([hsvt],[0,1],roihist,[0,180,0,256],1) 
		
		disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(5,5)) 
		cv2.filter2D(dst,-1,disc,dst) 
		
		thr = cv2.threshold(dst,50,255,0)[1]
		thr = cv2.merge((thr,thr,thr)) 
		res = cv2.bitwise_and(self.image,thr)
		#cv2.imwrite('result{}.png'.format(self.cnt), res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]])
		self.DataList.append( utill.processLog(res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]]) )

if __name__=="__main__":
	img_pro = Image_Processing()


