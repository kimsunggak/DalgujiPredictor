import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'bus_schedule_screen.dart';
//import 'bus_schedule_details_screen.dart'; // 이 부분 주석을 해제해서 BusScheduleDetailsScreen를 불러옵니다.
import 'start_enginner_234.dart';  // 이공관 출발 (화, 수, 목)
import 'start_giheung_234.dart';  // 기흥역 출발 (화, 수, 목)
import 'start_enginner_15.dart';  // 이공관 출발 (월, 금)
import 'start_giheung_15.dart';  // 기흥역 출발 (월, 금)
import 'time_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dalgugi Count',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',  // 앱 시작 화면을 로그인 화면으로 설정
      routes: {
        '/': (context) => LoginScreen(),
        '/busSchedule': (context) => const BusScheduleScreen(),
        //'/busScheduleDetails': (context) => const BusScheduleDetailsScreen(), // BusScheduleDetailsScreen 라우트 추가
        '/gongwanDeparture234': (context) => const GongwanDepartureScreen234(),  // 이공관 출발 (화, 수, 목)
        '/giheungDeparture234': (context) => const GiheungDepartureScreen234(),  // 기흥역 출발 (화, 수, 목)
        '/gongwanDeparture15': (context) => const GongwanDepartureScreen15(),  // 이공관 출발 (월, 금)
        '/giheungDeparture15': (context) => const GiheungDepartureScreen15(),  // 기흥역 출발 (월, 금)
        '/timeDetail': (context) => const TimeDetailScreen(),  // 시간대 세부 페이지
      },
    );
  }
}
