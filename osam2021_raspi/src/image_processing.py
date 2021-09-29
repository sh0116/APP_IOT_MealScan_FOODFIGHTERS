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
'''
draw = cv2.rectangle(draw, (50, 50), (430, 270), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (245, 155), (420, 260), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (60, 155), (235, 260), (0, 255, 0), 2)

draw = cv2.rectangle(draw, (60, 60), (175, 145), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (185, 60), (300, 145), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (310, 60), (420, 145), (0, 255, 0), 2)
'''
#미완성
class Image_Processing:
	def __init__(self, image):
		self.image = image
		self.images = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
		self.image_lenght_x,self.image_lenght_y,_ =  self.image.shape
		#cv2.imwrite("1.png", self.image)
		# Set values equal to or above 220 to 0.
		# Set values below 220 to 255.
		im_th = cv2.threshold(self.images, 180, 255, cv2.THRESH_BINARY_INV)[1]
		# Copy the thresholded image.
		im_floodfill = im_th.copy()
		# Mask used to flood filling.
		# Notice the size needs to be 2 pixels than the image.
		h, w = im_th.shape[:2]
		mask = np.zeros((h+2, w+2), np.uint8)
		# Floodfill from point (0, 0)
		cv2.floodFill(im_floodfill, mask, (0,0), 255)
		# Invert floodfilled image
		im_floodfill_inv = cv2.bitwise_not(im_floodfill)
		# Combine the two images to get the foreground.
		self.thresh = im_th | im_floodfill_inv

		self.side_dish = []
		self.main_dish = []

		cv2.imshow("Thresh", self.thresh)
		cv2.waitKey(0)
		self.D = ndimage.distance_transform_edt(self.thresh)
		self.localMax = peak_local_max(self.D, indices=False, min_distance=20,
			labels=self.thresh)
		# perform a connected component analysis on the local peaks,
		# using 8-connectivity, then appy the Watershed algorithm
		self.markers = ndimage.label(self.localMax, structure=np.ones((3, 3)))[0]
		self.labels = watershed(-self.D, self.markers, mask=self.thresh)
		print("[INFO] {} unique segments found".format(len(np.unique(self.labels)) - 1))

		dish = list()
		rect_range = [[245,420,155,260],[60,235,155,260],[60,175,60,145],[185,300,60,145],[310,420,60,145]]
		for x1,x2,y1,y2 in rect_range:
			dish.append([[x1,y2],[x1,y1],[x2,y1],[x2,y2]])
			
		# split main,side dish
		self.main_dish,self·side_dish  = dish[:2], dish[2:]

		# draw a circle enclosing the object
		self.rec_image = self.image.copy()
		self.cnt=1
		for self.box in self.side_dish:
			self.cnt+=1
			self.backProjection(self.image,self.rec_image[self.box[1][1]+10:self.box[0][1]-10,self.box[1][0]+20:self.box[2][0]-20])
			
		for self.box in self.main_dish:
			self.cnt+=1
			self.backProjection(self.image,self.rec_image[self.box[1][1]+40:self.box[0][1]-40,self.box[1][0]+40:self.box[2][0]-40].copy())
			


	# backProjection Function
	def backProjection(self,img,roi): 
		hsv = cv2.cvtColor(roi,cv2.COLOR_BGR2HSV) 
		hsvt = cv2.cvtColor(img,cv2.COLOR_BGR2HSV) 

		roihist = cv2.calcHist([hsv],[0,1],None,[180,256],[0,180,0,256]) 
		cv2.normalize(roihist,roihist,0,255,cv2.NORM_MINMAX) 
		dst = cv2.calcBackProject([hsvt],[0,1],roihist,[0,180,0,256],1) 
		
		disc = cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(5,5)) 
		cv2.filter2D(dst,-1,disc,dst) 
		
		thr = cv2.threshold(dst,50,255,0)[1]
		thr = cv2.merge((thr,thr,thr)) 
		res = cv2.bitwise_and(self.image,thr)
		#cv2.imwrite('result{}.png'.format(self.cnt), res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]])
		#print(self.cnt)
		utill.processLog(res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]])

if __name__=="__main__":
	img_pro = Image_Processing()


