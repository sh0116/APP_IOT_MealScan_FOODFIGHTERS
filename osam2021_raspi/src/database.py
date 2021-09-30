from firebase import firebase
import datetime
import time
import sys

# Create the connection to our Firebase database 
FBConn = firebase.FirebaseApplication('https://military-cafeteria-default-rtdb.firebaseio.com/', None)
dish_tag = ["side_1","side_2","side_3","rice","soup"]

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
    data_to_upload = {
        'ID' : id,
        'side_1': DataList[0],
        'side_2': DataList[1],
        'side_3': DataList[2],
        'rice'  : DataList[3],
        'soup'  : DataList[4],
    }

    # Post the data to the appropriate folder/branch within your database
    result = FBConn.post(test_id,data_to_upload)


    # Print the returned unique identifier
    return result

if __name__=="__main__":
    test()
    #exit(0)
    # Close the serial connection
    #ser.close()