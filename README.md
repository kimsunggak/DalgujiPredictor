<<<<<<< HEAD
# dc_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# 💻 프로젝트 소개 
## 🚌 **달구지 탑승 인원 예측 서비스** 🚌
강남대 셔틀버스 '달구지'의 특정 시간대 탑승 인원을 예측하여, 대기 시간을 줄이고 보다 효율적인 버스 이용을 돕는 서비스입니다.

## 프로젝트 배경 및 목표

강남대 셔틀버스 '달구지'는 학생들이 많이 이용하는 교통수단이지만, 제한된 버스 대수로 인해 오랜 시간 대기해도 셔틀버스를 이용하지 못하는 문제가 자주 발생합니다. 이로 인해 학생들이 수업에 지각하거나 급하게 택시를 이용하는 경우가 많습니다. 이를 해결하기 위해 AI를 활용하여 특정 요일과 시간대에 달구지를 이용할 수 있는지 예측하는 서비스를 개발하고자 합니다. 또한, 택시 동승자를 쉽게 찾을 수 있는 커뮤니티 기능을 제공하여 편리한 택시 이용을 지원하는 것이 목표입니다.


## 🌐 플랫폼 : 앱
이 프로젝트는 [Flutter](https://flutter.dev/)를 사용하여 개발되었습니다.


### 🔑 앱 화면 예
<img src="https://github.com/user-attachments/assets/5c959af4-a02e-4848-9cca-6f2b727c6104" alt="로그인 화면" width="300"/>
<img src="https://github.com/user-attachments/assets/76985972-f7a6-4615-a51d-3a6f3562f567" alt="메인 화면" width="300"/>


---

## 🛠️ 주요 기능 (Features)
- **실시간 대기 인원 예측**: 날씨, 시간, 전철 도착 여부 등의 데이터를 분석해 셔틀버스 대기 인원을 실시간으로 예측합니다.
- **셔틀버스 도착 알림**: 사용자가 설정한 시간에 맞춰 셔틀버스 도착 예정 시간을 푸시 알림으로 제공합니다.
- **챗봇 기능**: 채팅 봇을 통해 택시 동승자를 연결하고, 사용자 패턴에 맞춘 맞춤형 추천 서비스를 제공합니다.

---

## 🏗️ 시스템 구조
![image](https://github.com/user-attachments/assets/2062eca5-2b9f-47f6-ab25-d833fb2c0550)
### 1. 데이터베이스
- **역할**: 머신러닝 또는 딥러닝 모델을 학습시키기 위한 데이터를 저장하고 관리.
- **데이터 처리**: 과거의 평균 이용자 수를 기반으로 임의 데이터를 생성하고 저장.
- **사용 기술**: AWS RDS (클라우드에서 쉽게 관리 가능한 MySQL 환경 제공).

### 2. 앱 화면
- **기능**: 사용자가 예측된 대기 인원 수와 혼잡도 정보를 확인할 수 있는 인터페이스 제공.
- **사용 기술**: Flutter

### 3. API 서버
- **역할**: 예측 모델의 결과를 받아 앱으로 전달하고, 데이터베이스와 연동하여 요청 정보를 저장하거나 과거 데이터를 조회.
- **사용 기술**: AWS API 서버.
- **구현 계획**: FastAPI 서버 구축 예정

### 4. 예측 모델
- **기능**: 데이터베이스의 데이터를 바탕으로 특정 시간대에 대기 인원 수를 예측.
- **사용 기술**: 
  - **LSTM**: 시계열 데이터를 기반으로 한 딥러닝 모델로, 시간의 흐름에 따라 변하는 대기 인원을 예측합니다.
  - **XGBoost**: 기계 학습 모델로, 다양한 변수를 고려하여 대기 인원 수를 예측하는 데 사용됩니다.

---

## 📅 개발 일정

- **1~2주차**: 프로젝트 준비 및 주제 정의, UI/UX 초안 구성 및 모델 선택.
- **3~4주차**: 데이터베이스 생성, 모델 선택, Flutter 학습, 계획서 발표.
- **5~6주차**: 모델 학습 및 평가, 앱 기본 기능 개발.
- **7~8주차**: 서버 구축 및 API 연동, 1차 프로토타입 완성 및 중간평가 (기본 UI 시연).
- **9~12주차**: 모델 성능 개선 및 앱 기능 추가, 2차 프로토타입 완성 및 중간점검 (모델 연동 완료).
- **13~15주차**: 최종 기능 개발, 앱 및 예측 모델 배포, 최종 발표.

---

## 🎯 주요 개발 목표
- **1차 중간평가 목표**: 어플리케이션 UI 프로토타입 시연.
- **2차 중간평가 목표**: 모델과 연동된 전체 서비스 프로토타입 시연.
- **최종 평가 목표**: 어플리케이션 서버 배포, 예측 모델 배포.

## 🔧 설치 및 실행 방법

>>>>>>> 772693919c2093ff8fb4233b62dcc86c9555acb4
