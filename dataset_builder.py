import pandas as pd
import random

# 월요일과 금요일 아침 시간대 (11개)
time_slots_special_monday_and_friday = ['07:50', '08:00', '08:10', '08:15', '08:20', '08:25', '08:30',
                                        '08:35', '08:40', '08:50', '09:05']

# 화, 수, 목 아침 시간대 (16개)
time_slots_special = ['07:50', '07:55', '08:00', '08:05', '08:10', '08:15', '08:20', '08:25', '08:30',
                      '08:35', '08:40', '08:45', '08:50', '08:55', '09:00', '09:05']

# 일반 시간대 (20개)
time_slots_regular = ["10:30", "10:40", "10:50", "11:00", "11:10", "11:20", "11:30", "12:50", "13:10",
                      "13:30", "13:40", "14:00", "14:10", "14:20", "14:30", "15:00", "16:00", "17:00",
                      "17:20", "17:40"]

# 월요일과 금요일에 제외할 시간대 (화수목에만 있는 시간대)
exclude_on_monday_and_friday = ["10:40", "13:30", "13:50", "15:00", "16:00"]

# 요일에 따라 시간대 생성 (시간대 확률적으로 생성)
def generate_time(day):
    if day == 1 or day == 5:  # 월요일(1), 금요일(5)
        # 월, 금 시간대 (일부 시간대 제외)
        valid_time_slots = [time for time in time_slots_regular if time not in exclude_on_monday_and_friday]
        # 50% 확률로 아침 시간대 또는 일반 시간대 선택
        if random.random() < 0.5:
            return random.choice(time_slots_special_monday_and_friday)
        else:
            return random.choice(valid_time_slots)
    else:  # 화, 수, 목
        # 모든 시간대 포함
        valid_time_slots = time_slots_regular + time_slots_special
        return random.choice(valid_time_slots)

# 대기 인원 수 조정 함수
def adjust_waiting_passengers(time, weather, train_arrival, event):
    # 마지막 시간대 목록 정의 (마지막 시간대의 최대값 설정을 위해 - 일정 수 이상 많을 수 없음)
    last_time_slots = ['09:05', '11:30', '14:30', '17:40']
    # 마지막 시간대 바로 앞 시간대 목록 정의 (마지막 시간대 인원 수보다는 많지만 특정 수를 넘지 않게 하기 위함)
    pre_last_time_slots = ['08:50', '11:20', '14:20']
    
    # 시간대를 숫자로 변환하여 비교 (시간 비교를 위해)
    def time_to_minutes(t):
        h, m = map(int, t.split(':'))
        return h * 60 + m

    time_minutes = time_to_minutes(time)
    
    # 시간대별 가중치 설정 함수
    def get_time_slot_weight(time_minutes):
        # 아침 시간대 (08:15 ~ 08:40)
        if time_to_minutes("08:15") <= time_minutes <= time_to_minutes("08:40"):
            return 1.4  # 가장 높은 가중치
        # 두 번째로 중요한 시간대
        elif time_minutes in [time_to_minutes("08:10"), time_to_minutes("08:05"), time_to_minutes("08:45"),
                            time_to_minutes("14:10"), time_to_minutes("14:20")]:
            return 1.25
        # 세 번째로 중요한 시간대 (11:10, 11:20, 14:10, 14:20)
        elif time_minutes in [time_to_minutes("11:10"), time_to_minutes("11:20"),
                            time_to_minutes("14:10"), time_to_minutes("14:20")]:
            return 1.25
        # 네네 번째로 중요한 시간대 (11:00, 11:30, 14:00, 14:30)
        elif time_minutes in [time_to_minutes("11:00"), time_to_minutes("11:30"),
                            time_to_minutes("14:00"), time_to_minutes("14:30")]:
            return 1.05
        else:
            return 1.0  # 기본 가중치
    
    # 인원이 적은 시간대인 15시에서 17시 사이에는 최대 45명으로 제한
    if time_to_minutes("15:00") <= time_minutes <= time_to_minutes("17:00"):
        waiting_passengers = random.randint(5, 45)
        return waiting_passengers  # 이미 제한했으므로 반환

    # 날씨에 따른 가중치 설정
    # Weather: 1: 25도 이상(더움), 2: 25도 미만(선선함), 3: 흐림, 4: 비
    weather_weight = {
        1: 1.15,  # 더운 날은 대기 인원 증가
        2: 1.0,  # 선선한 날은 기본
        3: 0.95,  # 흐린 날은 약간 감소
        4: 1.18   # 비 오는 날은 대기 인원 크게 증가
    }
    
    # 이벤트 여부에 따른 가중치
    event_weight = 1.2 if event == 1 else 1.0

    # 전철 도착 여부에 따른 가중치
    train_arrival_weight = 1.3 if train_arrival == 1 else 1.0

     # 시간대별 가중치 계산
    time_slot_weight = get_time_slot_weight(time_minutes)
    
    # 시간대에 따른 기본 대기 인원 설정
    #마지막 바로 이전 시간대
    if time in pre_last_time_slots:
        base_min = 70
        base_max = 120
    #마지막 시간대
    elif time in last_time_slots:
        base_min = 10
        base_max = 70
        #사람이 가장 많은 시간대 - 아침 시간대
    elif (time_to_minutes("08:15") <= time_minutes <= time_to_minutes("08:40")) :
        base_min = 80
        base_max = 225
        #사람이 가장 많은 시간대 - 일반 시간대
    elif (time_to_minutes("11:00") <= time_minutes <= time_to_minutes("11:20") or
          time_to_minutes("14:00") <= time_minutes <= time_to_minutes("14:20")):
        base_min = 30
        base_max = 130
    else:
        base_min = 10
        base_max = 150

    # 기본 대기 인원 설정
    waiting_passengers = random.randint(base_min, base_max)

     # 총 가중치 계산
    total_weight = weather_weight[weather] * event_weight * train_arrival_weight * time_slot_weight

    # 가중치 적용
    waiting_passengers = int(waiting_passengers * total_weight)

    # 최대 최소값 제한
    waiting_passengers = max(0, min(waiting_passengers, 225))  # 최대 225명으로 제한

    return waiting_passengers

# 전철 도착 여부 설정 함수
def set_train_arrival(time):
    # 전철이 도착하는 시간대
    train_arrival_times = ["07:50", "08:00", "08:05", "08:10", "08:15", "08:20", "08:25", "08:30", "08:35",
                           "08:40", "08:45", "11:10", "11:20", "14:00", "14:10", "14:20"]
    # 해당 시간대에만 train_arrival을 1로 설정
    if time in train_arrival_times:
        return 1  # 전철 도착
    else:
        return 0  # 전철 도착 안 함

# 데이터 생성 함수
def generate_random_data(num_entries):
    data = []
    days = [1, 2, 3, 4, 5]  # 월요일부터 금요일까지
    num_entries_per_day = num_entries // 5  # 각 요일별 데이터 수 20프로씩 분배

    for day in days:
        for _ in range(num_entries_per_day):
            time = generate_time(day)  # 시간대 선택
            weather = random.randint(1, 4)  # 날씨 (1: 25도 이상, 2: 25도 미만, 3: 흐림, 4: 비)
            event = random.randint(0, 1)  # 이벤트 여부 (0: 없음, 1: 있음)
            bus_capacity = 45  # 버스 용량 (고정)
            train_arrival = set_train_arrival(time)  # 전철 도착 여부

            # 대기 인원 수 조정
            waiting_passengers = adjust_waiting_passengers(time, weather, train_arrival, event)

            data.append([day, time, weather, event, bus_capacity, train_arrival, waiting_passengers])

    return pd.DataFrame(data, columns=['Day', 'Time', 'Weather', 'Event', 'Bus_Capacity', 'Train_Arrival', 'Waiting_Passengers'])

# 50,000개의 데이터를 생성
df = generate_random_data(50000)

# CSV 파일로 저장
df.to_csv('ki.csv', index=False)
