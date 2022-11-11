// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../widgets/AppBarWidget.dart';
import '../../widgets/DrawerWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          // Custom App Bar widget
          AppBarWidget(),
        ],
      ),
      //Drawer
      drawer: const DrawerWidget(),
    );
  }
}
