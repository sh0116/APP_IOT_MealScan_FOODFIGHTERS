import cv2
import numpy as np
import time

from src import image_processing
from src import init_processing
from src import qr_processing
from src import database

# main process
class main_process():
    def __init__(self):
       
        self.cap = cv2.VideoCapture(0)
        # cv2.show size
        self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 320)
        # button point x1,y1,x2,y2
        self.button = [20,60,50,250]
        # fist state
        self.state = "init"
        # open camera
        self.webcam()

    # state check function
    def process_click(self, event, x, y, flags, params):
        if event == cv2.EVENT_LBUTTONDOWN:
            # if click botton
            if y > self.button[0] and y < self.button[1] and x > self.button[2] and x < self.button[3]: 
                print('Clicked on Button!')
                # check image capture
                ret, a = self.cap.read()

                # state init 
                if self.state=="init":
                    init_processing.Image_Processing(a)
                    self.state = "qr"

                # state qr
                elif self.state=="qr":
                    self.qr = qr_processing.Image_Processing(a)
                    self.qr_data = self.qr.Data()

                    if self.qr_data != "empty data":
                        self.state = "plate"

                # state plate 
                elif self.state=="plate":
                    process_class = image_processing.Image_Processing(a)
                    result = database.firebase_post(self.qr_data, process_class.DataList )

                    self.state = "qr"
            
    def webcam(self):
        # create a window and attach a mousecallback and a trackbar
        cv2.namedWindow('Control')
        cv2.setMouseCallback('Control',self.process_click)
        # create button image
        control_image = np.zeros((80,300), np.uint8)
        control_image[self.button[0]:self.button[1],self.button[2]:self.button[3]] = 180
        cv2.putText(control_image, 'Click',(100,50),cv2.FONT_HERSHEY_PLAIN, 2,(0),3)
        # show 'control panel'
        cv2.imshow('Control', control_image)

        # open camera
        if self.cap.isOpened():
            ret, a = self.cap.read()
            ret, b = self.cap.read()
            # camera still open
            while ret:
                ret, c = self.cap.read()
                draw = c.copy()
                # close camera
                if not ret:
                    break
                # cv2.show() in rectangle() show plate area

                #if self.state!="qr":
                draw = cv2.rectangle(draw, (50, 50), (430, 270), (0, 255, 0), 2)
                draw = cv2.rectangle(draw, (245, 155), (420, 260), (0, 255, 0), 2)
                draw = cv2.rectangle(draw, (60, 155), (235, 260), (0, 255, 0), 2)

                draw = cv2.rectangle(draw, (60, 60), (175, 145), (0, 255, 0), 2)
                draw = cv2.rectangle(draw, (185, 60), (300, 145), (0, 255, 0), 2)
                draw = cv2.rectangle(draw, (310, 60), (420, 145), (0, 255, 0), 2)



                # cv2.show() in rectangle() show qr area
                '''
                else:
                    draw = cv2.rectangle(draw, (190 , 110 ), (290, 210), (0, 255, 0), 2)
                '''
                cv2.imshow("main",draw)

                a = b
                b = c
        # close window
        cv2.destroyAllWindows()


if __name__=="__main__":
    main_process()
