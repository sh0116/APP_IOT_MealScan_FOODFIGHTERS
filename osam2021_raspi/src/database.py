from firebase import firebase
import datetime
import time
import sys

# Create the connection to our Firebase database 
FBConn = firebase.FirebaseApplication('https://military-cafeteria-default-rtdb.firebaseio.com/', None)

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
    elif 13 >= int(time.strftime('%H')) >= 11:
        cnt  = 1
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

if __name__=="__main__":
    firebase_post("21-76012345",[11.1,22.2,33.3,44.4,55.5])
    #exit(0)
    # Close the serial connection
    #ser.close()