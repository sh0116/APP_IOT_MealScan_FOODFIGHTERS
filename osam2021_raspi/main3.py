import cv2

cap = cv2.VideoCapture(0)

while(True):
    ret, cam = cap.read()

    if(ret) :
        cv2.imshow('camera', cam)
        
        
        if cv2.waitKey(1) & 0xFF == 27: # esc 키를 누르면 닫음
            break
                     
cap.release()
cv2.destroyAllWindows()