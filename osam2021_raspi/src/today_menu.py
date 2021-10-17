import numpy as np
import pandas as pd
import pytz
from datetime import date, datetime, timedelta
import math
#dictionary for mapping base code to menu code 
dic = {1 : 3389, 2: 6176, 3:1691}

#Function returing user's meal as a list
def get_menu(base_code=2): 
    #get path of csv file 
    #path for raspi
    
    path = '/home/pi/osam/APP_IOT_MealScan_FOODFIGHTERS/osam2021_raspi/asset/monthly_menu_base/base_'+ str(dic[base_code]) +'.csv'
    #path for codespace
    #path = '/workspaces/APP_IOT_AI_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/asset/monthly_menu_base/base_'+ str(dic[base_code]) +'.csv'
    #make a dataframe of user's menu
    df = pd.read_csv(path, encoding='euc-kr')
    today_date, meal_type = get_date_meal_type()
    #select today's menu according to date and meal_type
    df = df.loc[df['날짜'] == today_date]
    if meal_type == 1:
        df = df.iloc[0:5,1]
    elif meal_type == 2:
        df = df.iloc[0:5,3]
    else:
        df = df.iloc[0:5,5]
    #remove unneeded parts
    #final = [ i.split("(")[0] for i in df.tolist()]
    final = []
    for i in df.tolist():
        if isinstance(i, str):
            final.append(i.split("(")[0])
    #sorted for processing purposes
    final = sorted(final[2:]) + final[0:2]
    #make array length to 5
    while len(final) != 5:
        final =  [''] + final
    return final


#Function returing user's meal as a list
def get_menu_tomorrow(base_code=1): 
    #get path of csv file 
    #path for raspi
    path = '/home/pi/osam/APP_IOT_MealScan_FOODFIGHTERS/osam2021_raspi/asset/monthly_menu_base/base_'+ str(dic[base_code]) +'.csv'
    #path for codespace
    #path = '/workspaces/APP_IOT_AI_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/asset/monthly_menu_base/base_'+ str(dic[base_code]) +'.csv'
    #make a dataframe of user's menu
    df = pd.read_csv(path, encoding='euc-kr')
    tz = pytz.timezone('Asia/Seoul')
    #get tomorrow's date
    today_date = str(date.today() + timedelta(days=1))
    #select tomorrows's menus
    df1 = df.loc[df['날짜'] == today_date]
    df2 = df.loc[df['날짜'] == today_date]
    df3 = df.loc[df['날짜'] == today_date]
    df1 = df.iloc[0:5,1]
    df2 = df.iloc[0:5,3]
    df3 = df.iloc[0:5,5]
    #remove unneeded parts
    #final = [ i.split("(")[0] for i in df.tolist()]
    final1 = []
    final2 = []
    final3 = []
    for i in df1.tolist():
        if isinstance(i, str):
            final1.append(i.split("(")[0])
    for i in df2.tolist():
        if isinstance(i, str):
            final2.append(i.split("(")[0])
    for i in df3.tolist():
        if isinstance(i, str):
            final3.append(i.split("(")[0])
    #sorted for processing purposes
    final1 = sorted(final1[2:]) + final1[0:2]
    final2 = sorted(final2[2:]) + final2[0:2]
    final3 = sorted(final3[2:]) + final3[0:2]
    #make array length to 5
    while len(final1) != 5:
        final1 = [''] + final1
    while len(final2) != 5:
        final2 = [''] + final2
    while len(final3) != 5:
        final2 = [''] + final3
    print(final1, final2, final3)
    return [final1, final2, final3]

#Function returning today's date and meal type(1: breakfast, 2: lunch, 3: dinner)
def get_date_meal_type():
    #get time in Seoul
    tz = pytz.timezone('Asia/Seoul')
    curr_hour = datetime.now(tz).hour
    #decide which type of meal
    if curr_hour < 11:
        curr_meal = 1
    elif curr_hour < 16:
        curr_meal = 2
    else: 
        curr_meal = 3 
    return str(date.today()), curr_meal 

if __name__=="__main__":
    print(get_date_meal_type())
    print(get_menu(2))
    print(get_menu_tomorrow(1))