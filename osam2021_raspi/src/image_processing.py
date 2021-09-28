import cv2
import sys
import numpy as np
import os
import math
from skimage.feature import peak_local_max
from skimage.morphology import watershed
from scipy import ndimage
import imutils

import utill
'''
draw = cv2.rectangle(draw, (245, 155), (420, 260), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (60, 155), (235, 260), (0, 255, 0), 2)

draw = cv2.rectangle(draw, (60, 60), (175, 145), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (185, 60), (300, 145), (0, 255, 0), 2)
draw = cv2.rectangle(draw, (310, 60), (420, 145), (0, 255, 0), 2)
'''
class Image_Processing:
	def __init__(self):
		self.image = cv2.imread("1.png")
		self.images = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
		self.image_lenght_x,self.image_lenght_y,_ =  self.image.shape
		dish = list()
		rect_range = [[245,420,155,260],[60,235,155,260],[60,175,60,145],[185,300,60,145],[310,420,60,145]]
		for x1,x2,y1,y2 in rect_range:
			dish.append([[x1,y2],[x1,y1],[x2,y1],[x2,y2]])
		self.main_dish = dish[:2]
		self·side_dish = dish[2:]

		self.rec_image = self.image.copy()
		self.cnt=1
		for self.box in np.array(dish[2:]):
			cv2.putText(self.rec_image, "#{}".format(self.cnt), (self.box[1][0]+((self.box[2][0]-self.box[1][0])//2), self.box[1][1]+20),
				cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 0, 255), 2)
			cv2.drawContours(self.rec_image,[self.box],0,(0,255,0),3)
			self.cnt+=1
			#cv2.imshow("Output"+str(self.cnt), self.rec_image[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]].copy())
			#cv2.imshow("Output"+str(cnt), rec_image[box[1][1]+10:box[0][1]-10,box[1][0]+20:box[2][0]-20].copy())
			#cv2.waitKey(0)
			self.backProjection(self.image,self.rec_image[self.box[1][1]+5:self.box[0][1]-5,self.box[1][0]+5:self.box[2][0]-5])
			
		for self.box in np.array(dish[:2]):
			cv2.putText(self.rec_image, "#{}".format(self.cnt), (self.box[1][0]+((self.box[2][0]-self.box[1][0])//2), self.box[1][1]+20),
				cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 0, 255), 2)
			cv2.drawContours(self.rec_image,[self.box],0,(0,255,0),3)
			self.cnt+=1

			#cv2.imshow("Output"+str(self.cnt), self.rec_image[self.box[1][1]:self.box[0][1],self.box[1][0]:self.box[2][0]].copy())
			self.backProjection(self.image,self.rec_image[self.box[1][1]+40:self.box[0][1]-40,self.box[1][0]+40:self.box[2][0]-40].copy())
			
		#cv2.imshow("Output", self.rec_image)
		#cv2.waitKey(0)
		utill.main()
		print("bye")

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
