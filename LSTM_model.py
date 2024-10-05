#필요 라이브러리 호출
import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from keras.models import Sequential
from keras.layers import LSTM,Dense,Dropout

#데이터 전처리 (정규화된 데이터를 더 잘 학습함)
data = pd.read_csv("ki.csv")
#시간을 수치형 데이터로 변환하는 함수 설정 - 시간을 분단위로
def convert_time_to_minutes(time):
    hours,minutes = map(int,time.split(':'))
    return hours *60 + minutes


#0에서 1사이로 정규화
scaler = MinMaxScaler(feature_range=(0,1))
scaled_data = scaler.fit_transform(data["Waiting_Passengers"].values.reshape(-1,1))

