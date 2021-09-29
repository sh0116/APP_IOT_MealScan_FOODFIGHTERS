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

		self.box_list = []
		for self.label in np.unique(self.labels):
			# if the label is zero, we are examining the 'background'
			# so simply ignore it
			if self.label == 0:
				continue
			# otherwise, allocate memory for the label region and draw
			# it on the mask
			self.mask = np.zeros(self.images.shape, dtype="uint8")
			self.mask[self.labels == self.label] = 255
			# detect contours in the mask and grab the largest one
			self.cnts = cv2.findContours(self.mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
			self.cnts = imutils.grab_contours(self.cnts)
			self.c = max(self.cnts, key=cv2.contourArea)
			self.rect = cv2.minAreaRect(self.c)
			self.box = cv2.boxPoints(self.rect)
			self.box = np.int0(self.box)
			self.box_list.append(self.box)

		self.split_rect()
		print("main_dish : {}, side_dish : {}".format(len(self.main_dish),len(self.side_dish)))

		# draw a circle enclosing the object
		self.rec_image = self.image.copy()
		self.cnt=1
		for self.box in self.side_dish:
			cv2.putText(self.rec_image, "#{}".format(self.cnt), (self.box[1][0]+((self.box[2][0]-self.box[1][0])//2), self.box[1][1]+20),
				cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 0, 255), 2)
			cv2.drawContours(self.rec_image,[self.box],0,(0,255,0),3)
			self.cnt+=1
			cv2.imshow("Output"+str(self.cnt), self.rec_image[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]].copy())
			#cv2.imshow("Output"+str(cnt), rec_image[box[1][1]+10:box[0][1]-10,box[1][0]+20:box[2][0]-20].copy())
			cv2.waitKey(0)
			self.backProjection(self.image,self.rec_image[self.box[1][1]+10:self.box[0][1]-10,self.box[1][0]+20:self.box[2][0]-20])
			
		for self.box in self.main_dish:
			cv2.putText(self.rec_image, "#{}".format(self.cnt), (self.box[1][0]+((self.box[2][0]-self.box[1][0])//2), self.box[1][1]+20),
				cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 0, 255), 2)
			cv2.drawContours(self.rec_image,[self.box],0,(0,255,0),3)
			self.cnt+=1

			cv2.imshow("Output"+str(self.cnt), self.rec_image[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]].copy())
			self.backProjection(self.image,self.rec_image[self.box[1][1]+40:self.box[0][1]-40,self.box[1][0]+40:self.box[2][0]-40].copy())
			
		cv2.imshow("Output", self.rec_image)
		cv2.waitKey(0)

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
		cv2.imwrite('result{}.png'.format(self.cnt), res[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]])
		#print(self.cnt)

	# side_dish & main_dish split and split range
	def split_rect(self):
		self.ten_per = math.ceil((self.image_lenght_x/100)*10)
		self.box = list(a.tolist() for a in self.box_list)
		self.side_y_list = list(b[1][1] for b in self.box)
		self.side_y = self.side_y_list[0]
		self.side_dish = sorted(list(filter(lambda x : self.side_y-self.ten_per<=x[1][1] <= self.side_y+self.ten_per , self.box)), key= lambda x:x[1][0])
		self.main_dish = sorted(list(filter(lambda x : self.side_y-self.ten_per> x[1][1] or x[1][1]> self.side_y+self.ten_per , self.box)), key= lambda x:x[1][0])
		
		if len(self.main_dish)==3:
			self.side_dish,self.main_dish = self.main_dish,self.side_dish

		self.side_dish = np.array(self.side_dish)
		self.main_dish = np.array(self.main_dish)


if __name__=="__main__":
	img_pro = Image_Processing()
