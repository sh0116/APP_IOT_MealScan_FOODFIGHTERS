import cv2
import numpy as np
import os

class Image_Processing:
	def __init__(self, image):
		self.image = image
		self.images = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
		self.image_lenght_x,self.image_lenght_y,_ =  self.image.shape
		#cv2.imwrite("1.png", self.image)

		dish = list()
		rect_range = [[245,420,155,260],[60,235,155,260],[60,175,60,145],[185,300,60,145],[310,420,60,145]]
		for x1,x2,y1,y2 in rect_range:
			dish.append([[x1,y2],[x1,y1],[x2,y1],[x2,y2]])
			
		# split main,side dish
		self.main_dish,self·side_dish  = dish[:2], dish[2:]


		dish_tag = ["side_1","side_2","side_3","rice","soup"]
		self.cnt=0
		for self.box in np.array(self·side_dish):
			cv2.imwrite("../asset/{}.png".format(dish_tag[cnt]), self.image[self.box[1][1]+5:self.box[0][1]-5,self.box[1][0]+5:self.box[2][0]-5].copy() )
			self.cnt+=1

		for self.box in np.array(self.main_dish):
			cv2.imwrite("../asset/{}.png".format(dish_tag[cnt]), self.image[self.box[1][1]+10:self.box[0][1]-10,self.box[1][0]+10:self.box[2][0]-10].copy() )
			self.cnt+=1

if __name__=="__main__":
	img_pro = Image_Processing("../asset/result2.png")
