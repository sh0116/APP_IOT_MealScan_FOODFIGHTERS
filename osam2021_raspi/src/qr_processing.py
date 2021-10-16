import cv2
import numpy as np

# qr process class
class Image_Processing:
    def __init__(self, image):
        # QR code detection object
        self.detector = cv2.QRCodeDetector()
        # data is User info
        self.data, _, _ = self.detector.detectAndDecode(image)
        cv2.imshow("main",image)
    # get data info function
    def Data(self):
        if not self.data:
            self.data = "empty data"
        return self.data


if __name__=="__main__":
    img = cv2.imread("../asset/test_image/qr_test/qr_data.png")
    classd = Image_Processing(img)
    print(classd.data)

