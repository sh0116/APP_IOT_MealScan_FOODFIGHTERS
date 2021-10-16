import cv2
import numpy as np

# qr process class
class Image_Processing:
    def __init__(self, image):
        # QR code detection object
        self.detector = cv2.QRCodeDetector()
        # data is User info
        self.data, _, _ = self.detector.detectAndDecode(image)
    # get data info function
    def Data(self):
        if not self.data:
            self.data = "empty data"
        return self.data






if __name__=="__main__":
    img = cv2.imread("../asset/test_image/qr_test/qr_data.png")
    classd = Image_Processing(img)
    print(classd.data)

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
'''