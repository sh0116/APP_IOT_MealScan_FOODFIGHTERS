import numpy as np
import pandas as pd
import pytz
from datetime import date, datetime

#dictionary for mapping base code to menu code 
dic = {1 : 3389, 2: 6176, 3:1691}

#Function returing user's meal as a list
def get_menu(base_code): 
    #get path of csv file 
    path = '/workspaces/APP_IOT_AI_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/asset/monthly_menu_base/제'+ str(dic[base_code]) +'부대 식단 정보_월별.csv'
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
    final = [i.split("(")[0] for i in df.tolist()]
    #sorted for processing purposes
    final = sorted(final[2:]) + final[0:2]
    return final

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
    print(get_menu(1))