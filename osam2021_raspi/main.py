import cv2
import numpy as np
import time
from src import image_processing
from src import init_processing
from src import qr_processing
from src import database


class main_process():
    def __init__(self):
       
        a, b, c = None, None, None
        self.cap = cv2.VideoCapture(0)
        self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 320)
        # self.button dimensions (y1,y2,x1,x2)
        self.button = [20,60,50,250]
        # function that handles the mousclicks
        #state : init, qr, plate
        self.state = "init"
        self.webcam()


    def process_click(self, event, x, y, flags, params):
        # check if the click is within the dimensions of the self.button
        if event == cv2.EVENT_LBUTTONDOWN:
            if y > self.button[0] and y < self.button[1] and x > self.button[2] and x < self.button[3]: 
                print('Clicked on Button!')
                ret, a = self.cap.read()
                if self.state=="init":
                    init_processing.Image_Processing(a)
                    self.state = "qr"
                    
                elif self.state=="qr":
                    self.qr_data = qr_processing.Image_Processing(a)
                    self.state = "plate"

                elif self.state=="plate":
                    #database의 args에 self.qr_data
                    database.test()
                    init_processing.Image_Processing(a,self.qr_data)
                    self.state = "qr"
            
    def webcam(self):
        # create a window and attach a mousecallback and a trackbar
        cv2.namedWindow('Control')
        cv2.setMouseCallback('Control',self.process_click)
        # create button image
        control_image = np.zeros((80,300), np.uint8)
        control_image[self.button[0]:self.button[1],self.button[2]:self.button[3]] = 180
        cv2.putText(control_image, 'Click',(100,50),cv2.FONT_HERSHEY_PLAIN, 2,(0),3)
        #show 'control panel'
        cv2.imshow('Control', control_image)
        if self.cap.isOpened():
            ret, a = self.cap.read()
            ret, b = self.cap.read()

            while ret:
                ret, c = self.cap.read()
                draw = c.copy()
                if not ret:
                    break
                if self.state!="qr":
                    draw = cv2.rectangle(draw, (50, 50), (430, 270), (0, 255, 0), 2)
                    draw = cv2.rectangle(draw, (245, 155), (420, 260), (0, 255, 0), 2)
                    draw = cv2.rectangle(draw, (60, 155), (235, 260), (0, 255, 0), 2)

                    draw = cv2.rectangle(draw, (60, 60), (175, 145), (0, 255, 0), 2)
                    draw = cv2.rectangle(draw, (185, 60), (300, 145), (0, 255, 0), 2)
                    draw = cv2.rectangle(draw, (310, 60), (420, 145), (0, 255, 0), 2)
                    #stacked = np.hstack((draw, cv2.cvtColor(diff, cv2.COLOR_GRAY2BGR)))
                    if self.state!="init":
                        cv2.imshow('init process', draw)
                    else:
                        cv2.imshow('plate', draw)
                else:
                    draw = cv2.rectangle(draw, (190 , 110 ), (290, 210), (0, 255, 0), 2)
                    #stacked = np.hstack((draw, cv2.cvtColor(diff, cv2.COLOR_GRAY2BGR)))
                    cv2.imshow('qr', draw)
                a = b
                b = c

        cv2.destroyAllWindows()


if __name__=="__main__":
    main_process()
