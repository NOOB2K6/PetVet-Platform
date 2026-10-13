import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) {
      return;
    }

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;

      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.category);
        break;

      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.calendar);
        break;

      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.ai);
        break;

      case 4:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, Icons.home_outlined, 'Trang chủ', 0),

          _navItem(context, Icons.category_outlined, 'Danh mục', 1),

          _navItem(context, Icons.calendar_month_outlined, 'Lịch', 2),

          _navItem(context, Icons.smart_toy_outlined, 'AI', 3),

          _navItem(context, Icons.person_outline, 'Cá nhân', 4),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData icon,
    String title,
    int index,
  ) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: selected ? Colors.black : Colors.grey),

            const SizedBox(height: 4),

            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: selected ? Colors.black : Colors.grey,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
