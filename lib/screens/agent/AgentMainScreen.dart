// ignore_for_file: file_names, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/routes/RoutesHelper.dart';
import 'package:uburimyi_imbere/widgets/AgentAppBarWidget.dart';
import '../../provider/product_model.dart';
import '../../widgets/AgentDrawerWidget.dart';
import '../../widgets/big_text.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/no_data_page.dart';

class AgentMainScreen extends StatelessWidget {
  const AgentMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Products')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                    color: Colors.white,
                  ),
                ),

                Positioned(
                  top: Dimensions.height10,
                  left: Dimensions.width10 / 2,
                  right: Dimensions.width20,
                  child: AgentAppBarWidget(),
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
                                text: "Total of products : ",
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
                        color: Color(0xFFF5F5F3)),

                    // the content of the white background

                    child: snapshot.hasData && snapshot.data!.docs.isNotEmpty
                        ? Stack(
                            children: [
                              ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var productList =
                                        snapshot.data!.docs.map((category) {
                                      return Product.fromSnap(category);
                                    }).toList();
                                    Product product = productList[index];

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
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Container(
                                          width: 380,
                                          height: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 3))
                                              ]),
                                          child: Row(children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, "itemPage");
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Image.network(
                                                  product.photo,
                                                  height: 120,
                                                  width: 150,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 150,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(product.title,
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Text(
                                                    product.house,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    product.address,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    product.quantity.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      // fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 4,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    itemCount: 5,
                                                    itemSize: 18,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 4),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.blueAccent,
                                                    ),
                                                    onRatingUpdate: (index) {},
                                                  ),
                                                  Text(
                                                    "Fbu ${product.price.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.black,
                                                    size: 26,
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.cart,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          )
                        : const NoDataPage(
                            text: "No Product found",
                            imgPath: "assets/image/product.jpg",
                          ),
                  ),
                ),
              ],
            );
          }),

      //Drawer
      drawer: const AgentDrawerWidget(),
      // floatingactionbutton
      floatingActionButton: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ]),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RoutesHelper.getAddProductScreen());
          },
          child: Icon(
            CupertinoIcons.plus,
            size: 28,
            color: Colors.blueGrey,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
