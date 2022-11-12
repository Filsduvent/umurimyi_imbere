// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/RoutesHelper.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              accountName: Text(
                "Umurimyi Imbere",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail:
                  Text("Admin@gmail.com", style: TextStyle(fontSize: 16)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/image/logo.jpg"),
              ),
            ),
          ),

          // List Tile
          const ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.blueGrey,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          //
          const ListTile(
            leading: Icon(
              CupertinoIcons.list_bullet,
              color: Colors.blueGrey,
            ),
            title: Text(
              "All Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          //
          InkWell(
            onTap: () {
              Get.toNamed(RoutesHelper.getLoginScreen());
            },
            child: const ListTile(
              leading: Icon(
                Icons.login,
                color: Colors.blueGrey,
              ),
              title: Text(
                "Log In",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
