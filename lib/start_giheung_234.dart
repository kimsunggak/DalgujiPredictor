import 'package:flutter/material.dart';

class GiheungDepartureScreen234 extends StatefulWidget {
  const GiheungDepartureScreen234({super.key});

  @override
  GiheungDepartureScreen234State createState() => GiheungDepartureScreen234State();
}

class GiheungDepartureScreen234State extends State<GiheungDepartureScreen234> with SingleTickerProviderStateMixin {
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

    // 0에서 1로 변화하는 Tween 애니메이션 설정
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
            Stack(
              children: [
                Container(
                  height: 150,
                  color: const Color(0xFF87C6FE),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, size: 30),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 40,
                        child: Image.asset('assets/img/stop02.png', height: 80),
                      ),
                      // 버스 이미지가 오른쪽에서 왼쪽으로 이동하는 애니메이션
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            top: 60,
                            left: MediaQuery.of(context).size.width * _animation.value, // 애니메이션 값에 따른 위치
                            child: Image.asset('assets/img/bus.png', height: 80),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  top: 120,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // 텍스트와 버스 이미지를 가로로 배치 및 중앙 정렬
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2), // 검은색 테두리 추가
                  borderRadius: BorderRadius.circular(150), // 테두리 모서리 둥글게 설정
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
                  crossAxisAlignment: CrossAxisAlignment.center, // 세로축 중앙 정렬
                  children: [
                    // 버스 이미지가 왼쪽
                    Image.asset('assets/img/sidebus.png', height: 60),
                    const SizedBox(width: 10), // 이미지와 텍스트 사이 간격
                    // 텍스트 섹션
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                      children: [
                        Text(
                          '기흥역(4번 출구)',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8), // 텍스트 사이 간격
                        Text(
                          '기흥역(4번 출구) ➡️ 이공관',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 달력 아이콘과 요일 텍스트를 중앙 정렬로 추가
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 16.0), // 상단을 0으로 해서 더 위로 밀어 올림
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
                crossAxisAlignment: CrossAxisAlignment.start, // 세로축 상단 정렬
                children: [
                  // 달력 이미지
                  Image.asset('assets/img/time.png', height: 30),
                  const SizedBox(width: 8), // 이미지와 텍스트 간격
                  const Text(
                    '화요일, 수요일, 목요일',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 8.0,
                  radius: const Radius.circular(10),
                  child: ListView(
                    children: [
                      _buildTimeButton(context, '07:50~09:05', ['07:50', '08:00', '08:10', '08:20', '08:30', '08:40', '08:50', '09:00']),
                      _buildTimeButton(context, '10시', ['10:40', '10:50']),
                      _buildTimeButton(context, '11시', ['11:00', '11:10', '11:20']),
                      _buildTimeButton(context, '12시', ['12:50']),
                      _buildTimeButton(context, '13시', ['13:10', '13:40']),
                      _buildTimeButton(context, '14시', ['14:00', '14:10', '14:20']),
                      _buildTimeButton(context, '17시', ['17:00', '17:20', '17:40']),
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

  // 시간을 눌렀을 때 TimeDetailScreen으로 이동
  Widget _buildTimeButton(BuildContext context, String time, List<String> timeSlots) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // TimeDetailScreen으로 시간대와 시간 목록을 전달하며 이동
          Navigator.pushNamed(
            context,
            '/timeDetail',
            arguments: {'time': time, 'timeSlots': timeSlots},
          );
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
}
