import 'package:flutter/material.dart';
import 'InputFormScreen.dart'; // 파일 이름과 대소문자를 정확히 맞춤

class GiheungDepartureScreen15 extends StatefulWidget {
  const GiheungDepartureScreen15({super.key});

  @override
  GiheungDepartureScreen15State createState() => GiheungDepartureScreen15State();
}

class GiheungDepartureScreen15State extends State<GiheungDepartureScreen15> with SingleTickerProviderStateMixin {
  // 애니메이션 컨트롤러와 애니메이션 설정
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 설정 (10초 동안 애니메이션 실행)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // 1.0에서 0.08로 변화하는 Tween 애니메이션 설정
    _animation = Tween<double>(begin: 1.0, end: 0.08).animate(_controller);

    // 애니메이션 시작
    _controller.forward();
  }

  @override
  void dispose() {
    // 애니메이션 종료 시 컨트롤러 해제
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 상단 디자인 부분 (생략)
            // ...

            // 시간대 버튼 리스트
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 8.0,
                  radius: const Radius.circular(10),
                  child: ListView(
                    children: [
                      _buildTimeButton(context, '07:50~09:00', ['07:50', '08:00', '08:10', '08:20', '08:30', '08:40', '08:50', '09:00']),
                      _buildTimeButton(context, '10시', ['10:30', '10:50']),
                      _buildTimeButton(context, '11시', ['11:00', '11:10', '11:20', '11:30']),
                      _buildTimeButton(context, '12시', ['12:50']),
                      _buildTimeButton(context, '13시', ['13:10', '13:40']),
                      _buildTimeButton(context, '14시', ['14:00', '14:10', '14:20']),
                      _buildTimeButton(context, '17시', ['17:00', '17:30', '17:50']),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 시간대 버튼 위젯 생성
  Widget _buildTimeButton(BuildContext context, String time, List<String> timeSlots) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          _showTimeSlots(context, timeSlots);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA3D3FE),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black, // 글자색을 검정색으로 설정
          ),
        ),
      ),
    );
  }

  // 개별 시간 버튼들을 표시하는 함수
  void _showTimeSlots(BuildContext context, List<String> timeSlots) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: timeSlots.length,
            itemBuilder: (context, index) {
              String selectedTime = timeSlots[index];
              return ListTile(
                title: Text(
                  selectedTime,
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context); // 모달 닫기
                  // 선택한 시간 정보를 InputFormScreen으로 전달
                  TimeOfDay timeOfDay = TimeOfDay(
                    hour: int.parse(selectedTime.split(':')[0]),
                    minute: int.parse(selectedTime.split(':')[1]),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InputFormScreen(selectedTime: timeOfDay),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
