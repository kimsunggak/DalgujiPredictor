import 'package:flutter/material.dart';
import 'package:adoptive_calendar/adoptive_calendar.dart'; // Make sure to import the package

class GiheungDepartureScreen15 extends StatefulWidget {
  const GiheungDepartureScreen15({super.key});

  @override
  GiheungDepartureScreen15State createState() => GiheungDepartureScreen15State();
}

class GiheungDepartureScreen15State extends State<GiheungDepartureScreen15> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  DateTime? _selectedDate; // Holds the selected date

  @override
  void initState() {
    super.initState();
    // Animation controller setup (runs for 10 seconds)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.08).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
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
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Positioned(
                            top: 60,
                            left: MediaQuery.of(context).size.width * _animation.value,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(150),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/img/sidebus.png', height: 60),
                    const SizedBox(width: 10),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '기흥역(4번 출구)',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '기흥역(4번 출구) ➡️ 이공관 )',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/img/time.png', height: 30),
                  const SizedBox(width: 8),
                  const Text(
                    '월요일, 금요일',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Show the adoptive calendar dialog
                  _selectedDate = await showDialog<DateTime>(
                    context: context,
                    builder: (BuildContext context) {
                      return AdoptiveCalendar(
                        initialDate: DateTime.now(),
                        backgroundColor: Colors.white,
                        fontColor: Colors.black,
                        selectedColor: Colors.orange,
                        headingColor: Colors.blue,
                        barColor: Colors.blueGrey,
                      );
                    },
                  );
                  setState(() {});
                },
                child: const Text("Select Date"),
              ),
            ),
            if (_selectedDate != null)
              Text(
                'Selected Date: ${_selectedDate.toString()}',
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
