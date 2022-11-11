// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:uburimyi_imbere/screens/visitor/HomeScreen.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String initial = '/';

  static String getInitial() => '$initial';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomeScreen()),
  ];
}
