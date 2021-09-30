import cv2
import numpy as np


class Image_Processing:
    def __init__(self, image):
        # QR code detection object
        self.detector = cv2.QRCodeDetector()
        self.data, self.bbox, _ = self.detector.detectAndDecode(image)

    def Data(self):
        if not self.data:
            self.data = "empty data"
        return self.data


if __name__=="__main__":
    img = cv2.imread("../asset/test_image/qr_test/qr_Hello.png")
    classd = Image_Processing(img)
    print(classd.data)

