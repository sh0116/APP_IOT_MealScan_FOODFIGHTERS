import cv2
import numpy as np
import time
import image_processing
import database

thresh = 25
max_diff = 5
 
a, b, c = None, None, None
 
cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 320)
# button dimensions (y1,y2,x1,x2)
button = [20,60,50,250]
# function that handles the mousclicks
def process_click(event, x, y,flags, params):
    # check if the click is within the dimensions of the button
    if event == cv2.EVENT_LBUTTONDOWN:
        if y > button[0] and y < button[1] and x > button[2] and x < button[3]:   
            print('Clicked on Button!')
            ret, a = cap.read()
            database.test()
            image_processing.Image_Processing(a)
# function that handles the trackbar
          
# create a window and attach a mousecallback and a trackbar
cv2.namedWindow('Control')
cv2.setMouseCallback('Control',process_click)

# create button image
control_image = np.zeros((80,300), np.uint8)
control_image[button[0]:button[1],button[2]:button[3]] = 180
cv2.putText(control_image, 'Click',(100,50),cv2.FONT_HERSHEY_PLAIN, 2,(0),3)
#show 'control panel'
cv2.imshow('Control', control_image)
if cap.isOpened():
    ret, a = cap.read()
    ret, b = cap.read()

    while ret:
        ret, c = cap.read()
        draw = c.copy()
        if not ret:
            break

        draw = cv2.rectangle(draw, (50, 50), (430, 270), (0, 255, 0), 2)
        draw = cv2.rectangle(draw, (245, 155), (420, 260), (0, 255, 0), 2)
        draw = cv2.rectangle(draw, (60, 155), (235, 260), (0, 255, 0), 2)

        draw = cv2.rectangle(draw, (60, 60), (175, 145), (0, 255, 0), 2)
        draw = cv2.rectangle(draw, (185, 60), (300, 145), (0, 255, 0), 2)
        draw = cv2.rectangle(draw, (310, 60), (420, 145), (0, 255, 0), 2)
        #stacked = np.hstack((draw, cv2.cvtColor(diff, cv2.COLOR_GRAY2BGR)))
        cv2.imshow('motion', draw)
 
        a = b
        b = c
 
        if cv2.waitKey(1) & 0xFF == 27:
            ret, c = cap.read()
            cv2.imwrite("1.png", c)
            time.sleep(1)

cv2.waitKey(0)
cv2.destroyAllWindows()
