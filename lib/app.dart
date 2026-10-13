import 'package:flutter/material.dart';

import 'routes/app_routes.dart';

class GPETDemoApp extends StatelessWidget {
  const GPETDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'GPET Demo',

      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),

      initialRoute: AppRoutes.home,

      routes: AppRoutes.routes,
    );
  }
}
