import cv2
import numpy as np
import glob
def processLog(images):
    # transfer image to numpy array
    imnp = np.array(images)
    h, w = imnp.shape[:2]

    # Get list of unique colours...
    # Arrange all pixels into a tall column of 3 RGB values and find unique rows (colours)
    colours, counts = np.unique(imnp.reshape(-1,3), axis=0, return_counts=1)
    # Iterate through unique colours

    # counts[0] is RGB(0,0,0)
    # RGB(0,0,0) is masking area
    # 100*counts[0]) / total size
    proportion = (100 * counts[0]) / (h * w)

    return proportion

if __name__=="__main__":
    for filename in ["result2.png","result3.png","result5.png","result6.png","result4.png"]:
        processLog(filename)
