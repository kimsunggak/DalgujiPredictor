import pandas as pd
from sqlalchemy import create_engine


#CSV 파일 경로
csv_file_path = "C:/Users/LG/dc/dc_application_1/database/ki.csv"

# AWS RDS 연결 정보
username = "admin"
password = "ekfrnwlzkdnsxm"
host = "dalguji-db.c7gi2ay8yxqc.us-east-1.rds.amazonaws.com"
database = "data"
table_name = "train_data"

# SQLAlchemy 연결 문자열 생성
connection_string = f"mysql+pymysql://{username}:{password}@{host}/{database}"
# SQLAlchemy 엔진 생성
engine = create_engine(connection_string)

# CSV 파일 읽기 (Pandas 사용)
df = pd.read_csv(csv_file_path)

# CSV 데이터 삽입
df.to_sql('train_data', con=engine, if_exists='append', index=False)

print("CSV 데이터가 성공적으로 삽입되었습니다.")