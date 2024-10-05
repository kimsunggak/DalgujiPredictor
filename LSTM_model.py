#데이터 전처리 (정규화된 데이터를 더 잘 학습함)
import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from keras.models import Sequential
from keras.layers import LSTM,Dense,Dropout

data = pd.read_csv("ki.csv")
#0에서 1사이로 정규화
scaler = MinMaxScaler(feature_range=(0,1))
scaled_data = scaler.fit_transform(data["Waiting_Passengers"].values.reshape(-1,1))

