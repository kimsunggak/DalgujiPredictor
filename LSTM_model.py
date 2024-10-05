#필요 라이브러리 호출
import pandas as pd
import numpy as np
import torch
import torch.nn as nn
from sklearn.preprocessing import MinMaxScaler
from torch.utils.data import DataLoader,TensorDataset

#데이터 전처리 (정규화된 데이터를 더 잘 학습함)
data = pd.read_csv("ki.csv")
#시간을 수치형 데이터로 변환하는 함수 설정 - 시간을 분단위로
def convert_time_to_minutes(time):
    hours,minutes = map(int,time.split(':'))
    return hours *60 + minutes
data["Time"] = data["Time"].apply(convert_time_to_minutes)

#0에서 1사이로 정규화
scaler = MinMaxScaler(feature_range=(0,1))
scaled_data = scaler.fit_transform(data["Waiting_Passengers"].values.reshape(-1,1))

#PyTorch 텐서로 변환
x_data = torch.FloatTensor(scaled_data[:-1])
y_data = torch.FloatTensor(scaled_data[-1])

#LSTM 모델 정의
class LSTM(nn.Module):
    def __init__(self,input_size,hidden_size,output_size):
        super(LSTM,self).__init__()
        self.lstm = nn.LSTM(input_size,hidden_size,batch_first=True)
        self.fc = nn.Linear(hidden_size,output_size)
    def forward(self,x):
        lstm_out,_ = self.lstm(x)
        output = self.fc(lstm_out[:,-1,:])
        return output
#모델 초기화
input_size = 1
hidden_size = 50
output_size = 1
model = LSTM(input_size,hidden_size,output_size)



