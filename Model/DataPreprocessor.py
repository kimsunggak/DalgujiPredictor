import pandas as pd
class DataPreprocessor:
    def __init__(self, reference_date="2022-03-02", weather_mapping=None):
        # 기준 날짜 초기화
        self.reference_date = reference_date
        
        # 날씨 매핑 초기화 (기본값 설정)
        if weather_mapping is None:
            self.weather_mapping = {
                1: "Sunny",
                2: "Cloudy",
                3: "Rainy",
                4: "Snowy"
            }
        else:
            self.weather_mapping = weather_mapping

    def convert_time_to_minutes(self, df):
        # 'Time' 열을 분 단위로 변환하는 함수
        df['Time'] = df['Time'].apply(lambda time_str: int(time_str.split(':')[0]) * 60 + int(time_str.split(':')[1]))
        return df

    def convert_date_to_days(self, df):
        # 'Date' 열을 일수 차이로 변환
        df['Date'] = pd.to_datetime(df['Date'], errors='coerce')
        df['Days_Since'] = (df['Date'] - pd.Timestamp(self.reference_date)) // pd.Timedelta('1D')
        return df

    def map_weather(self, df):
        # 'Weather' 열을 문자열로 매핑
        df['Weather'] = df['Weather'].map(self.weather_mapping)
        return df

    def one_hot_encode(self, df):
        # Weather 열 원-핫 인코딩
        df = pd.get_dummies(df, columns=["Weather"])
        return df

    def preprocess(self, df):
        df = self.convert_time_to_minutes(df)
        df = self.convert_date_to_days(df)
        df = self.map_weather(df)          # 추가된 매핑 단계
        df = self.one_hot_encode(df)

        # 불필요한 열 제거
        if 'Date' in df.columns:
            df = df.drop(columns=['Date'])

        # bool 값들을 0과 1로 변환 (필요할 경우에만)
        for col in ['Weather_1', 'Weather_2', 'Weather_3', 'Weather_4']:
            if col in df.columns:
                df[col] = df[col].astype(int)

        return df

