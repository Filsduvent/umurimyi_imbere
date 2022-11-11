import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/RoutesHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F3),
      ),
      initialRoute: RoutesHelper.getInitial(),
      getPages: RoutesHelper.routes,
    );
  }
}
