// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/widgets/big_text.dart';

import '../routes/RoutesHelper.dart';

class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({Key? key}) : super(key: key);

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  String? username = "";
  String? image = "";
  String? email = "";

  Future _getDataFromDatabase() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()!["username"];
          image = snapshot.data()!["profilePhoto"];
          email = snapshot.data()!["email"];
        });
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _getDataFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              accountName: BigText(text: username!, color: Colors.white),
              accountEmail: BigText(text: email!, color: Colors.white),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(image!),
              ),
            ),
          ),

          // List Tile
          InkWell(
            onTap: () {
              Get.back();
            },
            child: ListTile(
                leading: const Icon(
                  CupertinoIcons.home,
                  color: Colors.blueGrey,
                ),
                title: BigText(text: "Home")),
          ),
          //
          InkWell(
            onTap: () {
              Get.toNamed(RoutesHelper.getAddAgentScreen());
            },
            child: ListTile(
                leading: const Icon(
                  CupertinoIcons.add_circled,
                  color: Colors.blueGrey,
                ),
                title: BigText(text: "Add Agents")),
          ),

          //
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                return Get.offAllNamed(RoutesHelper.getInitial());
              });
            },
            child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.blueGrey,
                ),
                title: BigText(text: "LogOut")),
          ),
        ],
      ),
    );
  }
}
