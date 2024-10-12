import json
import pickle
import numpy as np
import xgboost as xgb
#저장된 전처리 객체 호출
with open("dataset/data_preprocessor.pkl","rb") as preprocessor_file:
    preprocessor = pickle.load(preprocessor_file)
#저장된 모델 객체 호출
with open("Model/xgboost_model.pkl","rb") as model_file:
    model = pickle.load(model_file)

#lambda 핸들러 코드
def lambda_handler(event,context):
    #입력 데이터 불러오기
    input_data = json.loads(event['body'])
    #데이터 전처리
    processed_data = preprocessor.transform([input_data['features']])
    #예측 수행
    prediction = model.predict(processed_data)
    #결과 반환
    return {
        "statusCode" : 200,
        'body' : json.dumps({'prediction': prediction.tolist()})
    }