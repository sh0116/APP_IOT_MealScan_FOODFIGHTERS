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

'''
Firebase credential path: 'military-cafeteria-firebase-adminsdk-dt176-6bbbcb40fa.json'  
'''
# initialize  the connection to our Firebase database 
cred = credentials.Certificate('military-cafeteria-firebase-adminsdk-dt176-6bbbcb40fa.json')
firebase_admin.initialize_app(cred)
db = firestore.client()

#get date and meal_type
date, meal_type = today_menu.get_date_meal_type()
date_meal = date[2:] + '-'+str(meal_type)

#Function to send today's menu to firebase according to base code from init
def firebase_send_meal(base_code):
    menu = today_menu.get_menu(base_code)
    data = {
    u'1ITEMNAME': menu[0],
    u'2ITEMNAME': menu[1],
    u'3ITEMNAME': menu[2],
    u'4ITEMNAME': menu[3],
    u'5ITEMNAME': menu[4]
    }
    db.collection(u'MEALPLANS').document(str(base_code)).collection(u'MEALS').document(date_meal).set(data)

#Function to send user waste to firebase 
def firebase_send_user_waste(id, waste_list):
    #get total waste amount to the nearest number by averaging
    list_mean = round(sum(waste_list)/len(waste_list),2)
    data = {
    u'1ITEMAMOUNT': waste_list[0],
    u'2ITEMAMOUNT': waste_list[1],
    u'3ITEMAMOUNT': waste_list[2],
    u'4ITEMAMOUNT': waste_list[3],
    u'5ITEMAMOUNT': waste_list[4],
    u'TOTALAMOUNT': list_mean
    }
    db.collection(u'USER_FOOD_WASTE').document(id).collection(date_meal[3:5]).document(date_meal).set(data)

#Function to send image address saved in dropbox to firebase
def firebase_send_image(id, image_address):
    data = {
    u'IMAGE_ADDRESS': image_address
    }
    db.collection(u'IMAGES').document(id).collection(u'WASTE_IMAGES').document(date_meal).set(data)
    
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
    #dr = DropBoxManager()
    #dr.UpLoadFile()
    #print(dr.GetFileLink())
    firebase_send_user_waste('20-71209928',[20.22, 10.11, 30.33, 40.32, 10.22])
    firebase_send_image('20-71209928', 'https://www.dropbox.com/sh/nviozz69jq2fk2g/AAABjrsDoTppFd5-Ob2RRLGXa?dl=0&fbclid=IwAR2b7YFYHxw6g-ZsRu9EzTtBlULSRArFZ_nrxjYLHT-FPiuRQEaVOZ9DX8o&preview=100per.png')
    firebase_send_meal(2)
    #wget.download(dr.GetFileLink())
    #exit(0)
    # Close the serial connection
    #ser.close()
