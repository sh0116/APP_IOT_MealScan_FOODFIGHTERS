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

# set up camera object
cap = cv2.VideoCapture(0)

# QR code detection object
detector = cv2.QRCodeDetector()

while True:
    # get the image
    _, img = cap.read()
    # get bounding box coords and data
    data, bbox, _ = detector.detectAndDecode(img)
    if data:
            print("data found: ", data)
    # if there is a bounding box, draw one, along with the data
    if(bbox is not None):
        for i in range(len(bbox)):
            cv2.line(img, tuple(bbox[i][0]), tuple(bbox[(i+1) % len(bbox)][0]), color=(255,
                     0, 255), thickness=2)
        cv2.putText(img, data, (int(bbox[0][0][0]), int(bbox[0][0][1]) - 10), cv2.FONT_HERSHEY_SIMPLEX,
                    0.5, (0, 255, 0), 2)
        if data:
            print("data found: ", data)
    # display the image preview
    cv2.imshow("code detector", img)
    if(cv2.waitKey(1) == ord("q")):
        break
# free camera object and exit
cap.release()
cv2.destroyAllWindows()


if __name__=="__main__":
	img_pro = Image_Processing()
