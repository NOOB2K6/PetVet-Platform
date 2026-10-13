import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/ai_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/medical_screen.dart';
import '../screens/medicine_screen.dart';
import '../screens/medical_record_screen.dart';
import '../screens/category_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String ai = '/ai';
  static const String profile = '/profile';
  static const String medical = '/medical';
  static const String medicine = '/medicine';
  static const String medicalRecord = '/medical-record';
  static const String category = '/category';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    calendar: (context) => const CalendarScreen(),
    ai: (context) => const AIScreen(),
    profile: (context) => const ProfileScreen(),
    medical: (context) => const MedicalScreen(),
    medicine: (context) => const MedicineScreen(),
    medicalRecord: (context) => const MedicalRecordScreen(),
    category: (context) => const CategoryScreen(),
  };
}
