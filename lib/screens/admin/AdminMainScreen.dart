// ignore_for_file: file_names, sort_child_properties_last, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/user_model.dart';
import '../../routes/RoutesHelper.dart';
import '../../widgets/AdminAppBarWidget.dart';
import '../../widgets/AdminDrawerWidget.dart';
import '../../widgets/big_text.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/no_data_page.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('role', isEqualTo: "Agent")
              .where('status', isEqualTo: "Active")
              .snapshots(),
          builder: (c, snapshot) {
            return Stack(
              children: [
                // color cover back ground
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 400,
                    color: const Color(0xFFF5F5F3),
                  ),
                ),

                Positioned(
                  top: Dimensions.height10,
                  left: Dimensions.width10 / 2,
                  right: Dimensions.width20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      AdminAppBarWidget(),
                    ],
                  ),
                ),

                //The container with the number of items in firebase
                Positioned(
                  top: Dimensions.height20 * 5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    height: Dimensions.height45 * 1.3,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: "Total of agents : ",
                                color: Colors.white,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    left: Dimensions.width10,
                                    right: Dimensions.width10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                    BigText(
                                        text: snapshot.hasData
                                            ? snapshot.data!.docs.length
                                                .toString()
                                            : "0"),
                                    SizedBox(
                                      width: Dimensions.width10 / 2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //the white background on wich we have all delails
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: Dimensions.popularFoodImgSize - 120,
                  child: Container(
                    padding: EdgeInsets.only(
                        // left: Dimensions.width20,
                        // right: Dimensions.width20,
                        top: Dimensions.height10 / 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.white),

                    // the content of the white background

                    child: snapshot.hasData && snapshot.data!.docs.isNotEmpty
                        ? Stack(
                            children: [
                              ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    List<dynamic> agent =
                                        snapshot.data!.docs.map((user) {
                                      return User.fromSnap(user);
                                    }).toList();
                                    User Agents = agent[index];

                                    return GestureDetector(
                                      onTap: () {
                                        // Get.toNamed(RouteHelper
                                        //     .getValidSimpleUserDetailsScreen(
                                        //   index,
                                        //   "details",
                                        //   customer[index].uid,
                                        // ));
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           ValidSimpleUserDetails(
                                        //               pageId: index,
                                        //               page: "details",
                                        //               user: customers),
                                        //     ));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: Dimensions.width20,
                                            right: Dimensions.width20,
                                            bottom: Dimensions.height10),
                                        child: Row(
                                          children: [
                                            //image section
                                            Container(
                                              width: Dimensions.listViewImgSize,
                                              height:
                                                  Dimensions.listViewImgSize,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20 /
                                                            2),
                                                color: Colors.white38,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        Agents.profilePhoto)),
                                              ),
                                            ),
                                            //text container
                                            Expanded(
                                              child: Container(
                                                height: Dimensions
                                                        .listViewTextContSize +
                                                    20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            Dimensions
                                                                .radius20),
                                                  ),
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width20,
                                                      right:
                                                          Dimensions.width10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      BigText(
                                                          text:
                                                              Agents.username),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      BigText(
                                                        text: Agents.email,
                                                        size: Dimensions.font16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      BigText(
                                                        text: Agents.phone,
                                                        size: Dimensions.font16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height10,
                                                      ),
                                                      BigText(
                                                        text: Agents.ville,
                                                        size: Dimensions.font16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          )
                        : const NoDataPage(
                            text: "No Agent found",
                            imgPath: "assets/image/profile.png",
                          ),
                  ),
                ),
              ],
            );
          }),

      //Drawer
      drawer: const AdminDrawerWidget(),
      // floatingactionbutton
      floatingActionButton: buildNavigateButton(),
    );
  }

  buildNavigateButton() => FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15)),
        onPressed: () {
          Get.toNamed(RoutesHelper.getAddAgentScreen());
        },
      );
}
