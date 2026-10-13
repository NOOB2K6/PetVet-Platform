import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'GPET',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Thông tin thú cưng'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.vaccines_outlined),
              title: const Text('Tiêm phòng'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: const Text('Quản lý thuốc'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.notifications_none),
              title: const Text('Thông báo'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Cài đặt'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
