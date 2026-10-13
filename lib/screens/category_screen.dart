import 'package:flutter/material.dart';

import '../widgets/ategory_item.dart';
import '../widgets/bottom_nav.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        title: const Text(
          'Danh mục',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Khám phá',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Khám phá các danh mục chăm sóc thú cưng',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 25),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CategoryItem(icon: '🐶', title: 'Chó', onTap: () {}),

                CategoryItem(icon: '🐱', title: 'Mèo', onTap: () {}),

                CategoryItem(icon: '🐰', title: 'Thỏ', onTap: () {}),

                CategoryItem(icon: '🐹', title: 'Hamster', onTap: () {}),

                CategoryItem(icon: '🐦', title: 'Chim', onTap: () {}),

                CategoryItem(icon: '🐢', title: 'Rùa', onTap: () {}),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
