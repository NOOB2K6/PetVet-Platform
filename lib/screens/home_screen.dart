import 'package:flutter/material.dart';
import '../widgets/pet_card.dart';
import '../widgets/service_card.dart';
import '../widgets/ai_card.dart';
import '../widgets/bottom_nav.dart';
import '../routes/app_routes.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      // Header
      appBar: const AppTopBar(),

      drawer: const AppDrawer(),

      body: SafeArea(
        child: Column(
          children: [
            // Nội dung chính
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),

                    // Wellcome
                    const Text(
                      'Xin chào, Hiếu 👋',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Hôm nay thú cưng của bạn thế nào?',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),

                    const SizedBox(height: 30),

                    // Pet Card
                    const PetCard(),

                    const SizedBox(height: 30),

                    const Text(
                      'Dịch vụ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Services
                    Row(
                      children: [
                        Expanded(
                          child: ServiceCard(
                            icon: Icons.medical_services_outlined,
                            title: 'Khám bệnh',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.medical);
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ServiceCard(
                            icon: Icons.calendar_month_outlined,
                            title: 'Lịch hẹn',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.calendar);
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: ServiceCard(
                            icon: Icons.medication_outlined,
                            title: 'Thuốc',
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.medicine);
                            },
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ServiceCard(
                            icon: Icons.description_outlined,
                            title: 'Hồ sơ',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.medicalRecord,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    const Text(
                      'Trợ lý AI',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const AICard(),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            const BottomNav(currentIndex: 0),
          ],
        ),
      ),
    );
  }
}
