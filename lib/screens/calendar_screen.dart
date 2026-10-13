import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch hẹn')),

      body: const Center(
        child: Text(
          'Trang Lịch hẹn',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
