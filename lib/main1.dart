import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dalgugi Count',
      home: LoginScreen(), // 앱 시작 시 로그인 화면으로 설정
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 타이틀 텍스트 (Dalgugi Count)
                  const Text(
                    'Dalgugi',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const Text(
                    'Count',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 이미지 섹션 (버스 정류장 + 버스)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/stop02.png', height: 150), // 버스 정류장 이미지
                      const SizedBox(width: 20),
                      Image.asset('assets/bus.png', height: 150), // 버스 이미지
                    ],
                  ),
                  const SizedBox(height: 40), // 이미지와 입력 필드 사이의 간격 조정

                  // 학번 입력
                  TextField(
                    controller: studentIdController,
                    decoration: const InputDecoration(
                      labelText: '학번을 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 비밀번호 입력
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호를 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),

                  // 로그인 버튼
                  ElevatedButton(
                    onPressed: () {
                      // 로그인 성공 시 BusScheduleScreen으로 이동
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const BusScheduleScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('로그인', style: TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(height: 10),

                  // 비밀번호 재설정 링크
                  TextButton(
                    onPressed: () {
                      // 비밀번호 재설정 관련 동작
                    },
                    child: const Text(
                      '비밀번호 재설정',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BusScheduleScreen extends StatelessWidget {
  const BusScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 상단 이미지 섹션
            Container(
              width: double.infinity,
              height: 130,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 버스 정류장 이미지를 가장 왼쪽에 배치
                  Positioned(
                    left: 0,
                    top: 8,
                    bottom: 0,
                    child: Image.asset('assets/stop02.png', height: 70),
                  ),
                  // 버스 이미지를 중앙에 배치
                  Positioned(
                    left: 58,
                    top: 8,
                    bottom: -42,
                    child: Image.asset('assets/bus.png', height: 150),
                  ),
                  // 사람 아이콘을 오른쪽에 배치
                  const Positioned(
                    right: 0,
                    top: 60,
                    child: Icon(Icons.person, size: 70),
                  ),
                ],
              ),
            ),
            // 아래 파란색 배경 + 버스 시간표 섹션
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF87C6FE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '2024-2 학기 순환버스 운행 시간표',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '원하는 시간대, 장소를 선택하세요',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '🚍강남대학교 → 기흥역(4번 출구)',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // 스크롤바 적용된 버스 시간표 리스트
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true, // 스크롤바 항상 보이도록 설정
                          thickness: 8.0, // 스크롤바 두께
                          radius: const Radius.circular(10), // 스크롤바 모서리 둥글게 설정
                          controller: ScrollController(), // 스크롤 컨트롤러 추가
                          child: ListView(
                            children: [
                              _buildCustomButton(context, '기흥역 출발(4번 출구)', '월요일, 금요일', const Color(0xFF2A69A1)),
                              _buildCustomButton(context, '이공관 출발', '월요일, 금요일', const Color(0xFF496E30)),
                              _buildCustomButton(context, '기흥역 출발(4번 출구)', '화요일, 수요일, 목요일', const Color(0xFF2A69A1)),
                              _buildCustomButton(context, '이공관 출발', '화요일, 수요일, 목요일', const Color(0xFF496E30)),
                            ],
                          ),
                        ),
                      ),
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

  // _buildCustomButton 메소드 (버튼 클릭 시 BusScheduleDetailsScreen으로 전환)
  Widget _buildCustomButton(BuildContext context, String title, String subtitle, Color borderColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          // 버튼을 클릭했을 때 BusScheduleDetailsScreen으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BusScheduleDetailsScreen(),
            ),
          );
        },
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class BusScheduleDetailsScreen extends StatelessWidget {
  const BusScheduleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 상단 이미지 섹션
            Stack(
              children: [
                Container(
                  height: 150,
                  color: const Color(0xFF87C6FE), // 파란색 배경
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 20,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, size: 30),
                          onPressed: () {
                            // 뒤로 가기 버튼을 눌렀을 때 메인 화면으로 전환
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 40,
                        child: Image.asset('assets/stop02.png', height: 80),
                      ),
                      Positioned(
                        top: 40,
                        right: 40,
                        child: Image.asset('assets/bus.png', height: 80),
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
            // 기흥역 정보 카드
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_bus, size: 40),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '기흥역(4번 출구)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '기흥역(4번 출구) → 이공관',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        '월요일, 금요일',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 시간대 버튼 섹션
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 8.0,
                  radius: const Radius.circular(10),
                  controller: ScrollController(),
                  child: ListView(
                    children: [
                      _buildTimeButton(context, '07:50~09:00'),
                      _buildTimeButton(context, '10시'),
                      _buildTimeButton(context, '11시'),
                      _buildTimeButton(context, '12시'),
                      _buildTimeButton(context, '13시'),
                      _buildTimeButton(context, '14시'),
                      _buildTimeButton(context, '17시'),
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

  // 시간대 버튼을 빌드하는 메소드
  Widget _buildTimeButton(BuildContext context, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // 시간대 버튼을 눌렀을 때 다른 화면으로 전환
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimeDetailScreen(time: time),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent, // 버튼 색상
          padding: const EdgeInsets.symmetric(vertical: 16), // 버튼 높이 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // 버튼의 둥근 모서리
          ),
        ),
        child: Text(
          time,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class TimeDetailScreen extends StatelessWidget {
  final String time;

  const TimeDetailScreen({required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Detail - $time'),
      ),
      body: Center(
        child: Text(
          'Selected Time: $time',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
