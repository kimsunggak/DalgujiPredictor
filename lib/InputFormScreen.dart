import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 형식 변환을 위해 사용
import 'package:http/http.dart' as http;
import 'dart:convert';

class InputFormScreen extends StatefulWidget {
  const InputFormScreen({super.key, required this.selectedTime});
  // super parameter 사용
  final TimeOfDay selectedTime; // 선택한 시간을 받을 변수 추가
  @override
  InputFormScreenState createState() => InputFormScreenState();
}

class InputFormScreenState extends State<InputFormScreen> {
  // 입력받을 변수들 선언
  DateTime selectedDate = DateTime.now();
  int day = 1; // 1: 월요일, ..., 7: 일요일
  late TimeOfDay selectedTime;
  int weather = 1; 
  bool event = false; // 이벤트 여부
  bool trainArrival = false; // 기차 도착 여부

  // 예측 결과를 저장할 변수
  String result = '';

  // 폼 키
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    // 디버깅용 로그
    print('현재 선택된 날씨 값: $weather');
    print('날씨 아이템 리스트: 0, 1, 2, 3');

    return Scaffold(
      appBar: AppBar(
        title: const Text('데이터 입력'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Date 입력
              ListTile(
                title: Text('날짜: ${DateFormat('yyyy-MM-dd').format(selectedDate)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              // Day 입력
              DropdownButtonFormField<int>(
                value: day,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('월요일')),
                  DropdownMenuItem(value: 2, child: Text('화요일')),
                  DropdownMenuItem(value: 3, child: Text('수요일')),
                  DropdownMenuItem(value: 4, child: Text('목요일')),
                  DropdownMenuItem(value: 5, child: Text('금요일')),
                  DropdownMenuItem(value: 6, child: Text('토요일')),
                  DropdownMenuItem(value: 7, child: Text('일요일')),
                ],
                onChanged: (value) {
                  setState(() {
                    day = value!;
                    print('요일이 변경되었습니다: $day');
                  });
                },
                decoration: const InputDecoration(labelText: '요일'),
              ),
              // Time 입력
              ListTile(
                title: Text('시간: ${selectedTime.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              // Weather 입력
              DropdownButtonFormField<int>(
                value: weather,
                items: const [
                  DropdownMenuItem(value: 1, child: Text('맑음')),
                  DropdownMenuItem(value: 2, child: Text('흐림')),
                  DropdownMenuItem(value: 3, child: Text('비')),
                  DropdownMenuItem(value: 4, child: Text('눈')),
                ],
                onChanged: (value) {
                  setState(() {
                    weather = value!;
                  });
                },
                decoration: const InputDecoration(labelText: '날씨'),
              ),
              // Event 입력
              SwitchListTile(
                title: const Text('이벤트 여부'),
                value: event,
                onChanged: (value) {
                  setState(() {
                    event = value;
                    print('이벤트 여부가 변경되었습니다: $event');
                  });
                },
              ),
              // Train Arrival 입력
              SwitchListTile(
                title: const Text('기차 도착 여부'),
                value: trainArrival,
                onChanged: (value) {
                  setState(() {
                    trainArrival = value;
                    print('기차 도착 여부가 변경되었습니다: $trainArrival');
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('예측하기'),
              ),
              const SizedBox(height: 20),
              // 결과를 표시하는 부분
              if (result.isNotEmpty)
                Text(
                  result,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // 날짜 선택 함수 정의
  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
        print('날짜가 변경되었습니다: $selectedDate');
      });
    }
  }

  // 시간 선택 함수 정의
  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() {
        selectedTime = time;
        print('시간이 변경되었습니다: $selectedTime');
      });
    }
  }

  // 데이터 제출 함수 정의
  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      print('예측하기 버튼이 눌렸습니다.');
      // 데이터를 모아서 서버로 전송
      Map<String, dynamic> requestData = {
        'Date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'Day': day,
        'Time': '${selectedTime.hour}:${selectedTime.minute}',
        'Weather': weather,
        'Event': event ? 1 : 0,
        'Train_Arrival': trainArrival ? 1 : 0,  
      };

      try {
        // 서버 URL 설정
        final url = Uri.parse('https://0516-211-238-109-139.ngrok-free.app/predict');
        print('요청 URL: $url');
        print('요청 데이터: $requestData');
        print('서버로 요청을 보냅니다.');
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestData),
        );
        print('서버 응답 코드: ${response.statusCode}');
        print('서버 응답 데이터: ${response.body}');
        if (response.statusCode == 200) {
          // 예측 결과 받기
          final responseData = jsonDecode(response.body);
          setState(() {
            result = '예측된 대기 인원 수: ${responseData['prediction']}명';
          });
        } else {
          setState(() {
            result = '예측에 실패했습니다. 상태 코드: ${response.statusCode}';
          });
        }
      } catch (e) {
        setState(() {
          result = '에러 발생: $e';
        });
        print('서버 요청 중 에러 발생: $e');
      }
    }
  }
}
