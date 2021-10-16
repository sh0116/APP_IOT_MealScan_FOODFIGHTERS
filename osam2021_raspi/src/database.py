from firebase import firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import storage
from uuid import uuid4
from src import today_menu
import datetime
import time
import sys
#import wget

'''
Firebase credential path: 'military-cafeteria-firebase-adminsdk-dt176-6bbbcb40fa.json'  
'''
# initialize  the connection to our Firebase database 
#cred for codespace
#cred = credentials.Certificate('military-cafeteria-firebase-adminsdk-dt176-6bbbcb40fa.json')
#cred for raspi
cred = credentials.Certificate('/home/pi/osam/APP_IOT_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/src/military-cafeteria-firebase-adminsdk-dt176-6bbbcb40fa.json')
firebase_admin.initialize_app(cred, {
    'storageBucket': 'military-cafeteria.appspot.com'
})
db = firestore.client()
bucket = storage.bucket()

#get date and meal_type
date, meal_type = today_menu.get_date_meal_type()
date_meal = date[2:] + '-'+str(meal_type)

#Function to send today's menu data according to base code from init to Firebase Firestore Database
def firebase_send_meal(base_code):
    #get today's menu from today_menu.py
    menu = today_menu.get_menu(base_code)
    #set data
    data = {
    u'1ITEMNAME': menu[0],
    u'2ITEMNAME': menu[1],
    u'3ITEMNAME': menu[2],
    u'4ITEMNAME': menu[3],
    u'5ITEMNAME': menu[4]
    }
    #send to Firebase Firestore Database
    db.collection(u'MEALPLANS').document(str(base_code)).collection(u'MEALS').document(date_meal).set(data)



#Function to send user waste data to Firebase Firestore Database
def firebase_send_user_waste(id, waste_list):
    #get total waste amount to the nearest number by averaging
    list_mean = round(sum(waste_list)/len(waste_list),2)
    #set data
    data1 = {
    u'1ITEMAMOUNT': waste_list[0],
    u'2ITEMAMOUNT': waste_list[1],
    u'3ITEMAMOUNT': waste_list[2],
    u'4ITEMAMOUNT': waste_list[3],
    u'5ITEMAMOUNT': waste_list[4],
    u'TOTALAMOUNT': list_mean
    }
    #send to Firebase Firestore Database
    db.collection(u'USER_FOOD_WASTE').document(id).collection(date_meal[3:5]).document(date_meal).set(data1)
    #get current food waste avg doc
    avg_update_doc = db.collection('USER_FOOD_WASTE_AVG').document(id)
    #format mean for db
    #if food waste avg doc exists update with input data else make new doc and input data
    if avg_update_doc.get().exists:
        curr_arr = avg_update_doc.get().to_dict()["WASTE_ARR"]
        new_arr =curr_arr+ [list_mean]
        #get new_average and format
        new_avg = str(round(sum(new_arr)/len(new_arr),2)) + '%'
        #set data
        data2 = {
            u'WASTE_ARR': new_arr,
            u'WASTE_AVG': new_avg
            }
        #send to Firebase Firestore Database
        avg_update_doc.set(data2)
    else:
        new_arr = [list_mean]
        #get new_average and format
        new_avg = str(round(sum(new_arr)/len(new_arr),2)) + '%'
        #set data
        data2 = {
            u'WASTE_ARR': new_arr,
            u'WASTE_AVG': new_avg
            }
        #send to Firebase Firestore Database
        avg_update_doc.set(data2)
    #get participaring challenges from Firebase Firestore Database
    doc_ref_chal = db.collection(u'USER_CHALLENGES').document(id)
    #get base code from Firebase Firestore Database
    doc_ref_base = db.collection(u'USER').document(id)
    #get values needed for update
    part_list  = doc_ref_chal.get().to_dict()['PARTICIPATING']
    base_code = doc_ref_base.get().to_dict()['BASE_CODE']
    #update challange db and leaderboard
    for i in part_list:
        #foramt id for db
        id_format = id + '_AVG'
        data3 = {
            id_format : new_avg
        }
        #get doc needed for update
        chalrank_update_doc = db.collection(u'CHALLENGE_RANK').document(base_code).collection(i).document("RANK")
        chalrank_update_doc.update(data3)
        #send to Firebase Firestore Database
        parti = chalrank_update_doc.get().to_dict()['PARTICIPANTS']
        lb = []
        #make leaderboard based on food_waste
        for i in parti:
            lb += [[(chalrank_update_doc.get().to_dict()[i+'_AVG']).split('%')[0], i]]
        lb_for_send = [j for i,j in sorted(lb, reverse= True)]
        data4 = {
            u'LEADERBOARD' : lb_for_send
        }
        #send to Firebase Firestore Database
        chalrank_update_doc.update(data4)



#Function to send image data to Firebase Storage and send image path to Firebase Firestore
def firestore_send_image(id, image_address, waste_list):
    #set image path in Firebase Storage
    blob = bucket.blob(id +'/'+date_meal +'.png')
    #set accesstoken and metadata
    new_token = uuid4()
    metadata = {"firebaseStorageDownloadTokens": new_token} #access token이 필요하다.
    blob.metadata = metadata
    #upload image to Firebase Storage
    blob.upload_from_filename(image_address)
    #make blob public for simple access
    blob.make_public()
    #get url and set data
    blob_url = blob.public_url
    #get meal type in korean
    if meal_type == 1:
        meal_type_kor = '조식' 
    elif meal_type == 2:
        meal_type_kor = '중식'
    else:
        meal_type_kor = '석식'
    #get total waste amount to the nearest number by averaging
    list_mean = str(round(sum(waste_list)/len(waste_list),2)) + '%'
    data = {
        u'IMAGE_ADDRESS': blob_url,
        u'DATE': date,
        u'MEALTYPE': meal_type_kor,
        u'PERCENTAGE': list_mean
    }
    #send to Firebase Firestore Database
    db.collection(u'IMAGES').document(id).collection('WASTE_IMAGES').document(date_meal).set(data)



if __name__=="__main__":
    id = '20-71209928'
    b_code = 1
    w_list = [99,99, 99, 99, 99]
    #path for raspi
    i_address = '/home/pi/osam/APP_IOT_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/asset/test_image/100_per/100per.png'
    #path for codespace
    #i_address = "/workspaces/APP_IOT_AI_Meal-Mil-Scan_FOODFIGHTERS/Meal_Mil_Scan/assets/images/meal2.jpg"
    firebase_send_meal(b_code)
    firebase_send_user_waste(id,w_list)
    firestore_send_image(id, i_address, w_list)
    print("Successfully sent data to Firebase")

'''
App key
h18mokh27adozq8
App secret
iieazt3mrgs02uv

class DropBoxManager:
    def __init__(self):
        #public repo 하면 안됨 토큰값 -> 보안상의 목적으로는 환경변수로 등록하고 환경변수의 값을 불러오는 형태로 해야함.
        #편의상 올려놓음 주의바람
        self.token = "sl.A6IL75RRqHngbTKqYBErVIYQFtla37lnn95H4FhILVxoyfTYBDhZAQcoUeIbNAflVVOXJNcQ2sauvNle8guzsGVKW7fnwZX2jsGyyJTj6Mn4dkDY30Sx3Dg8RDo0Boj87JmJqzTJ7qJC"
        self.fileName = "/workspaces/AP"
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
'''
