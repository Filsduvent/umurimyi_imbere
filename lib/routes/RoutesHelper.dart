// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:uburimyi_imbere/screens/admin/AddAgentForm.dart';
import 'package:uburimyi_imbere/screens/agent/AddProductScreen.dart';
import 'package:uburimyi_imbere/screens/agent/AgentMainScreen.dart';
import 'package:uburimyi_imbere/screens/visitor/HomeScreen.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/screens/visitor/LoginScreen.dart';

import '../screens/admin/AdminMainScreen.dart';
import '../screens/visitor/splash_screen.dart';

class RoutesHelper {
  static const String splashScreen = "/splash-screen";
  static const String initial = '/';
  static const String logIn = "/log-in";
  //admin
  static const String adminMain = '/admin-main';
  static const String addAgent = '/add-agent';
  //Agent
  static const String agentMain = '/agent-main';
  static const String addProduct = '/add-product';

  static String getSplashPage() => '$splashScreen';
  static String getInitial() => '$initial';
  static String getLoginScreen() => '$logIn';
  //Admin
  static String getAdminMainScreen() => '$adminMain';
  static String getAddAgentScreen() => '$addAgent';
  //Agent
  static String getAgentMainScreen() => '$agentMain';
  static String getAddProductScreen() => '$addProduct';

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomeScreen()),
    GetPage(
        name: logIn,
        page: () {
          return const LoginScreen();
        },
        transition: Transition.fade),

    //Admin
    GetPage(
        name: adminMain,
        page: () {
          return const AdminMainScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: addAgent,
        page: () {
          return const AddAgentScreen();
        },
        transition: Transition.zoom),

    //Agent
    GetPage(
        name: agentMain,
        page: () {
          return const AgentMainScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: addProduct,
        page: () {
          return const AddProductScreen();
        },
        transition: Transition.zoom),
  ];
}
