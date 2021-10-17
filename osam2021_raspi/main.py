import cv2
import numpy as np
import time

from src import image_processing
from src import init_processing
#from src import qr_processing
from src import database

# main process
class main_process():
    def __init__(self):
       
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
                    #database.firebase_send_meal(today_menu.get_menu(1))
                    self.state = "qr"
                
                # state plate 
                elif self.state=="plate":
                    process_class = image_processing.Image_Processing(a)
                    b_code, user_data = int(self.qr_data[:4]), self.qr_data[4:]
                    b_code = 1
                    #path for raspi
                    i_address = '/home/pi/osam/APP_IOT_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/asset/temp_result/temp.png'
                    #path for codespace
                    w_list = process_class.DataList
                    print(w_list,b_code,user_data)
                    database.firebase_send_user_waste(user_data, w_list)
                    database.firestore_send_image(user_data, i_address, w_list)

                    print("Successfully sent data to Firebase")

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

        # camera setting
        self.cap = cv2.VideoCapture(0)
        self.detector = cv2.QRCodeDetector()

        self.cap.set(cv2.CAP_PROP_FRAME_WIDTH, 480)
        self.cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 360)

        # open camera
        while(True):
            ret, f = self.cap.read()               
            frame = f.copy()
            data, bbox, _ = self.detector.detectAndDecode(f)

            # if there is a bounding box, draw one, along with the data
            if (bbox is not None):
                for i in range(len(bbox)):
                    cv2.line(frame, tuple(bbox[i][0]), tuple(bbox[(i+1) % len(bbox)][0]), color=(0, 255, 0), thickness=2)
                cv2.putText(frame, data, (int(bbox[0][0][0]), int(bbox[0][0][1]) - 10), cv2.FONT_HERSHEY_SIMPLEX,
                            0.5, (0, 255, 0), 2)
                if self.state == "qr" and data:
                    print("data found: ", data)
                    self.state = "plate"
                    self.qr_data = data


            if cv2.waitKey(1) & 0xFF == 27: # esc 키를 누르면 닫음
                break
            #frame = cv2.flip(frame, 0)
            # cv2.show() in rectangle() show plate area
            if self.state!="qr":
                frame = cv2.rectangle(frame, (20, 20), (420, 325), (0, 255, 0), 2)
                frame = cv2.rectangle(frame, (230, 155), (405, 315), (0, 255, 0), 2)
                frame = cv2.rectangle(frame, (35, 155), (220, 315), (0, 255, 0), 2)

                frame = cv2.rectangle(frame, (35, 35), (160, 145), (0, 255, 0), 2)
                frame = cv2.rectangle(frame, (175, 35), (270, 145), (0, 255, 0), 2)
                frame = cv2.rectangle(frame, (285, 35), (405, 145), (0, 255, 0), 2)

            cv2.imshow("main",frame)

        # close window
        self.cap.release()
        cv2.destroyAllWindows()

if __name__=="__main__":
    main_process()