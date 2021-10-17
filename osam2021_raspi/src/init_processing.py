import cv2
import numpy as np
import os
from src import database
from src import today_menu

# init process class
class Image_Processing:
	def __init__(self, image):
		# get image from main_process
		self.image = image
		self.images = cv2.cvtColor(self.image, cv2.COLOR_BGR2GRAY)
		self.image_lenght_x,self.image_lenght_y,_ =  self.image.shape

		# split image (x,y)point
		dish = list()
		rect_range = [[230,405,155,315],[35,220,155,315],[35,160,35,145],[175,270,35,145],[285,405,35,145]]
		for x1,x2,y1,y2 in rect_range:
			dish.append([[x1,y2],[x1,y1],[x2,y1],[x2,y2]])
			
		# split main,side dish
		self.main_dish,self·side_dish  = dish[:2], dish[2:]

		# split image save in local (Path : ~/asset/*.png)
		dish_tag = ["side_1","side_2","side_3","rice","soup"]
		self.cnt=0
		for self.box in np.array(self·side_dish):
			cv2.imwrite("/home/pi/osam/APP_IOT_MealScan_FOODFIGHTERS/osam2021_raspi/asset/{}.png".format(dish_tag[self.cnt]), self.image[self.box[1][1]+5:self.box[0][1]-5,self.box[1][0]+5:self.box[2][0]-5].copy() )
			self.cnt+=1

		for self.box in np.array(self.main_dish):
			cv2.imwrite("/home/pi/osam/APP_IOT_MealScan_FOODFIGHTERSS/osam2021_raspi/asset/{}.png".format(dish_tag[self.cnt]), self.image[self.box[1][1]+10:self.box[0][1]-10,self.box[1][0]+10:self.box[2][0]-10].copy() )
			self.cnt+=1


if __name__=="__main__":
	img_pro = Image_Processing("../asset/result2.png")
