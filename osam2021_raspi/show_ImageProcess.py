import numpy as np
import matplotlib.pyplot as plt
import cv2 

per_list = ["70_per","50_per","30_per","0_per"]
dish_tag = ["_side_1","_side_2","_side_3","_rice","_soup"]
fig = plt.figure() # rows*cols 행렬의 i번째 subplot 생성
rows = 2
cols = 2

for tag in dish_tag:
  total_images = 4
  cnt = 1
  fig = plt.figure() # rows*cols 행렬의 i번째 subplot 생성
  rows = 2
  cols = 2
  print("\n {} : images".format(tag))
  for per in per_list:
    img = cv2.imread("asset/result_test_image/result_{}{}.png".format(per,tag))
    ax = fig.add_subplot(rows, cols, cnt)
    ax.imshow(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    ax.set_xlabel("result_{}{}.png".format(per,tag))
    ax.set_xticks([]), ax.set_yticks([])
    cnt+=1
  plt.show()