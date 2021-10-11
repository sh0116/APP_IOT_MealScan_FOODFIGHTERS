from firebase import firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import today_menu
import datetime
import time
import sys
import dropbox
import wget
# initialize  the connection to our Firebase database 
cred = credentials.Certificate('military-cafeteria-firebase-adminsdk-dt176-6bbbcb40fa.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

#get date and meal_type
date, meal_type = today_menu.get_date_meal()
date_meal = date[2:] + '-'+str(meal_type)

def send_image_firebase(id, image_address):
    data = {
    u'IMAGE_ADDRESS': image_address,
    }
    db.collection(u'IMAGES').document(id).collection(u'WASTE_IMAGES').document(date_meal).set(data)
    

def test():
    test_id = "20-71209876"
    test_food1 = '김치'
    test_food1_amount = 36.7
    # Create a dictionary to store the data before sending to the database
    data_to_upload = {
        'ID' : test_id,
        'Food1': test_food1,
        'Food1_Amount': test_food1_amount
    }

    # Post the data to the appropriate folder/branch within your database
    result = FBConn.post(test_id,data_to_upload)


    # Print the returned unique identifier
    print(result)
    return result

def firebase_post(id, DataList):
    # Create a dictionary to store the data before sending to the database
    if 10 >= int(time.strftime('%H')) >= 6:
        cnt  = 1
    elif 15 >= int(time.strftime('%H')) >= 11:
        cnt  = 2
    else:
        cnt  = 3

    now_time = time.strftime('%y-%m-%d %H:%M:%S')
    now_time2 = time.strftime('%y-%m-%d_') + str(cnt)
    data_to_upload = \
    {'ID': id ,
        "item" : {
            'Time' : now_time,
            'Item_1': DataList[0],
            'Item_2': DataList[1],
            'Item_3': DataList[2],
            'Item_4'  : DataList[3],
            'Item_5'  : DataList[4],
            }
    }

    # Post the data to the appropriate folder/branch within your database
    result = FBConn.post(now_time2,data_to_upload)


    # Print the returned unique identifier
    return result

'''
App key
h18mokh27adozq8
App secret
iieazt3mrgs02uv
'''

class DropBoxManager:
    def __init__(self):
        #public repo 하면 안됨 토큰값 -> 보안상의 목적으로는 환경변수로 등록하고 환경변수의 값을 불러오는 형태로 해야함.
        #편의상 올려놓음 주의바람
        self.token = "sl.A6IL75RRqHngbTKqYBErVIYQFtla37lnn95H4FhILVxoyfTYBDhZAQcoUeIbNAflVVOXJNcQ2sauvNle8guzsGVKW7fnwZX2jsGyyJTj6Mn4dkDY30Sx3Dg8RDo0Boj87JmJqzTJ7qJC"
        self.fileName = "/workspaces/APP_IOT_AI_MilitaryCafeteria_FOODFIGHTERS/osam2021_raspi/asset/test_image/100_per/100per.png"
        self.pathName = "/{}/100per.png".format(time.strftime('%y_%m_%d'))
 
    def UpLoadFile(self):
        dbx = dropbox.Dropbox(self.token,timeout=900)
        with open(self.fileName, "rb") as f:
            dbx.files_upload(f.read(), self.pathName, mode=dropbox.files.WriteMode.overwrite)
 
    def GetFileLink(self):
        dbx = dropbox.Dropbox(self.token,timeout=900)
        shared_URL = dbx.sharing_create_shared_link_with_settings("/monthly_menu_base/제1691부대 식단 정보_월별.csv").url
        modified_URL = shared_URL[:-1] + '1'
        return modified_URL


if __name__=="__main__":
    #firebase_post("21-76012345",[11.1,22.2,33.3,44.4,55.5])
    #dr = DropBoxManager()
    #dr.UpLoadFile()
    #print(dr.GetFileLink())
    send_image_firebase('20-71209928', 'https://www.dropbox.com/s/ykv4pxtj9drmo2u/242400462_1373290829734827_6153053469246703892_n.jpg?dl=0')
    #wget.download(dr.GetFileLink())
    #exit(0)
    # Close the serial connection
    #ser.close()
