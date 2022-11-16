// ignore_for_file: file_names, unused_local_variable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/routes/RoutesHelper.dart';

import '../../widgets/show_custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: !loading
          ? SafeArea(
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Hello there
                  const Text(
                    "Hello There!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome back, you've been missed!",
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  // email textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Email")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //password textfield

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // signin button

                  GestureDetector(
                    onTap: () {
                      loginUser(emailController.text, passwordController.text);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.blueGrey,
            )),
    );
  }

  void loginUser(String email, String password) async {
    setState(() {
      loading = false;
    });

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential credit = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (credit != null) {
          readData(credit).then((value) async {
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(credit.user!.uid)
                .get()
                .then((DocumentSnapshot snapshot) {
              var jsons = snapshot.data() as Map<String, dynamic>;
              if (jsons['role'] == 'Admin') {
                Get.offAllNamed(RoutesHelper.getAdminMainScreen());
              } else if (jsons['role'] == 'Agent' &&
                  jsons['status'] == 'Active') {
                Get.offAllNamed(RoutesHelper.getAgentMainScreen());
              } else {
                showCustomSnackBar("This account might be blocked",
                    title: 'Role management');
              }
            });
          });
        }
      } else {
        showCustomSnackBar(
          'Error Login',
          title: "Login",
        );
      }
    } catch (e) {
      showCustomSnackBar(
        'Error Login: Incorrect initials',
        title: "Login",
      );
    }
    setState(() {
      loading = true;
    });
  }

  Future readData(UserCredential credit) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(credit.user!.uid)
        .get()
        .then((dataSnapshot) async {
      var json = dataSnapshot.data() as Map<String, dynamic>;
      json['role'];
    });
  }
}
