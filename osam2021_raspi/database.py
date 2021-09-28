from firebase import firebase
import datetime
import time
import sys

# Create the connection to our Firebase database - don't forget to change the URL!
FBConn = firebase.FirebaseApplication('https://military-cafeteria-default-rtdb.firebaseio.com/', None)
def test():
    test_id = "20-71209876"
    test_food1 = '김치'
    test_food1_amount = 36.7
    print(True)
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
test()
    #exit(0)
    # Close the serial connection
    #ser.close()