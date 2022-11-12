// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:uburimyi_imbere/screens/visitor/HomeScreen.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/screens/visitor/LoginScreen.dart';

class RoutesHelper {
  static const String initial = '/';
  static const String logIn = "/log-in";

  static String getInitial() => '$initial';
  static String getLoginScreen() => '$logIn';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const HomeScreen()),
    GetPage(
        name: logIn,
        page: () {
          return const LoginScreen();
        },
        transition: Transition.fade),
  ];
}
