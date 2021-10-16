from firebase import firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from firebase_admin import storage
from uuid import uuid4
from src import today_menu
from datetime import date, datetime, timedelta
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
date_tod, meal_type = today_menu.get_date_meal_type()
date_meal = date_tod[2:] + '-'+str(meal_type)

#Function to send today's menu data according to base code from init to Firebase Firestore Database
def firebase_send_meal(base_code):
    #get today's menu from today_menu.py
    menu = today_menu.get_menu(base_code)
    #set data
    data1 = {
    u'1ITEMNAME': menu[0],
    u'2ITEMNAME': menu[1],
    u'3ITEMNAME': menu[2],
    u'4ITEMNAME': menu[3],
    u'5ITEMNAME': menu[4]
    }
    #send to Firebase Firestore Database
    db.collection(u'MEALPLANS').document(str(base_code)).collection(u'MEALS').document(date_meal).set(data1)
    #send tommorow's menu in breakfast
    if meal_type == 1:
        #get tomorrow's menus
        tom_arr = today_menu.get_menu_tomorrow(base_code)
        for i in range(len(tom_arr)):
            #set data
            data2 = {
                u'1ITEMNAME': tom_arr[i][0],
                u'2ITEMNAME': tom_arr[i][1],
                u'3ITEMNAME': tom_arr[i][2],
                u'4ITEMNAME': tom_arr[i][3],
                u'5ITEMNAME': tom_arr[i][4]
                }
            #format document id
            tom_date_mealtype = str(date.today() + timedelta(days=1))[2:]  +'-'+ str(i+1)
            #send to Firebase Firestore Database
            db.collection(u'MEALPLANS').document(str(base_code)).collection(u'MEALS').document(tom_date_mealtype).set(data2)



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
        #update data
        data2 = {
            u'WASTE_ARR': new_arr,
            u'WASTE_AVG': new_avg
            }
        #send to Firebase Firestore Database
        avg_update_doc.update(data2)
        #get today's average
        if meal_type == 3:
            #get today's date and format
            dow = datetime.today().strftime('%A')[0:3].upper()
            #get today's avg
            today_avg = round(sum(new_arr[-3:])/3, 2)
            #update date
            data2_1 = {
                dow: today_avg
            }
            #send to Firebase Firestore Database
            avg_update_doc.update(data2_1)
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
            #send name when updating leaderboard
            name = db.collection(u'USER').document(i).get().to_dict()['NAME']
            lb += [[(chalrank_update_doc.get().to_dict()[i+'_AVG']).split('%')[0], i, name]]
        lb_for_send = [j + ' : ' + k for i,j,k in sorted(lb, reverse= True)]
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
    #firebase_send_meal(b_code)
    firebase_send_user_waste(id,w_list)
    #firestore_send_image(id, i_address, w_list)
    print("Successfully sent data to Firebase")