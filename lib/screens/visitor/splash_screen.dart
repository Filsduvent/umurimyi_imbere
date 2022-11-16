import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/routes/RoutesHelper.dart';
import '../../widgets/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? role = "";

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          role = snapshot.data()!["role"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getDataFromDatabase();
    Timer(const Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser != null && role == "Admin") {
        Get.offNamed(RoutesHelper.getAdminMainScreen());
      } else if (FirebaseAuth.instance.currentUser != null && role == "Agent") {
        Get.offNamed(RoutesHelper.getAgentMainScreen());
      } else {
        Get.offNamed(RoutesHelper.getInitial());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          height: Dimensions.height20 * 5,
          width: Dimensions.width20 * 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.height20 * 5 / 2),
              color: Colors.white),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
