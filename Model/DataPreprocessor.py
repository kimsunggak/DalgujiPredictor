import pandas as pd
class DataPreprocessor:
    def __init__(self, reference_date="2022-03-02", weather_mapping=None):
        # 기준 날짜 초기화
        self.reference_date = reference_date
        
    def convert_time_to_minutes(self, df):
        # 'Time' 열을 분 단위로 변환하는 함수
        df['Time'] = df['Time'].apply(lambda time_str: int(time_str.split(':')[0]) * 60 + int(time_str.split(':')[1]))
        return df

    def convert_date_to_days(self, df):
        # 'Date' 열을 일수 차이로 변환
        df['Date'] = pd.to_datetime(df['Date'], errors='coerce')
        df['Days_Since'] = (df['Date'] - pd.Timestamp(self.reference_date)) // pd.Timedelta('1D')
        return df

    def one_hot_encode(self, df):
        # Weather 열 원-핫 인코딩
        df = pd.get_dummies(df, columns=["Weather"])
        return df

    def preprocess(self, df):
        df = self.convert_time_to_minutes(df)
        df = self.convert_date_to_days(df)
        df = self.one_hot_encode(df)
        
        # 모든 Weather 컬럼을 포함하도록 보장
        expected_weather_columns = ['Weather_1', 'Weather_2', 'Weather_3', 'Weather_4']
        for col in expected_weather_columns:
            if col not in df.columns:
                df[col] = 0  # 해당 컬럼이 없으면 0으로 추가

        # 불필요한 열 제거
        if 'Date' in df.columns:
            df = df.drop(columns=['Date'])
        
        # 모든 열을 정수형으로 변환
        df = df.astype(int)

        return df

