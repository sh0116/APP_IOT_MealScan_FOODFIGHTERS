import cv2
import numpy as np
import glob
def processLog(images):
    #images = cv2.imread(img)
    # Open this image and make a Numpy version for easy processing
    imnp = np.array(images)
    h, w = imnp.shape[:2]
    # Get list of unique colours...
    # Arrange all pixels into a tall column of 3 RGB values and find unique rows (colours)
    colours, counts = np.unique(imnp.reshape(-1,3), axis=0, return_counts=1)
    # Iterate through unique colours
    count = counts[0]
    proportion = (100 * count) / (h * w)
    colour = [0,0,0]
    #print(f"   Colour: {colour}, count: {count}, proportion: {proportion:.2f}%")
    return 100.0 - proportion
# Iterate over all images called "log*png" in current directory
def main():
    for filename in ["result2.png","result3.png","result5.png","result6.png","result4.png"]:
        processLog(filename)