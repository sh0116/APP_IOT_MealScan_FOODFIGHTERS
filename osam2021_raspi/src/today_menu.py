import numpy as np
import pandas as pd

excel_file = '제3389부대'
path = '/workspaces/APP_IOT_AI_Meal-Mil-Scan_FOODFIGHTERS/osam2021_raspi/asset/monthly_menu_base/'+ excel_file +' 식단 정보_월별.csv'

df = pd.read_csv(path, encoding='euc-kr')

print(df['날짜'][0])