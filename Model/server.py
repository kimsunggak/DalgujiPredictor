import pickle
#데이터의 유효성 자동 검사
from pydantic import BaseModel
from fastapi import FastAPI
import xgboost as xgb
from DataPreprocessor import DataPreprocessor
#요청 데이터 구조 정의 - 유효성 검사(잘못된 데이터가 들어오지 않도록)
class PredictionRequest(BaseModel):
    date : str
    time : str
    day : int
    weather : int
    event : int
    train_arrival : int

app = FastAPI()
@app.get("/")
async def read_root():
    return {"message": "Server is running!"}
with open("xgboost_model.pkl", "rb") as f:
    model = pickle.load(f)