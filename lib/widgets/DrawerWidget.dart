// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/widgets/big_text.dart';

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
          InkWell(
            onTap: () {
              Get.back();
            },
            child: ListTile(
              leading: const Icon(
                CupertinoIcons.home,
                color: Colors.blueGrey,
              ),
              title: BigText(
                text: "Home",
                size: 20,
              ),
            ),
          ),
          //
          ListTile(
              leading: const Icon(
                CupertinoIcons.list_bullet,
                color: Colors.blueGrey,
              ),
              title: BigText(
                text: "All Products",
                size: 20,
              )),

          //
          InkWell(
            onTap: () {
              Get.toNamed(RoutesHelper.getLoginScreen());
            },
            child: ListTile(
                leading: const Icon(
                  Icons.login,
                  color: Colors.blueGrey,
                ),
                title: BigText(text: "Login")),
          ),
        ],
      ),
    );
  }
}
