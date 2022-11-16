// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/screens/visitor/ProductByProvinceScreen.dart';
import 'package:uburimyi_imbere/screens/visitor/search_screen.dart';

import '../../provider/product_model.dart';
import '../../provider/province_model.dart';
import '../../widgets/AppBarWidget.dart';
import '../../widgets/DrawerWidget.dart';
import '../../widgets/big_text.dart';
import '../../widgets/dimensions.dart';
import 'ItemPage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Custom App Bar widget
            const AppBarWidget(),

            //Search
            InkWell(
              onTap: (() {
                Get.to(const SearchProductScreen());
              }),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.search,
                          color: Colors.black,
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "What would you like to have?",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.filter_list)
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Explorer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Provinces')
                    .snapshots(),
                builder: (c, snap) {
                  return snap.hasData && snap.data!.docs.isNotEmpty
                      ? Container(
                          height: 50,
                          child: ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snap.data!.docs.length,
                              itemBuilder: (context, index) {
                                var provinceList = snap.data!.docs.map((pro) {
                                  return Province.fromSnap(pro);
                                }).toList();
                                Province province = provinceList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProductByProvinceScreen(
                                          pageId: index,
                                          page: "home",
                                          province: province,
                                        ));
                                  },
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ProductByProvinceScreen(
                                                pageId: index,
                                                page: "home",
                                                province: province,
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3))
                                                ]),
                                            child: BigText(text: province.name),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.blueGrey,
                        );
                }),

            // Category

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Newest",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('quantity', isGreaterThan: 0)
                    .snapshots(),
                builder: (c, snap) {
                  return snap.hasData && snap.data!.docs.isNotEmpty
                      ? Container(
                          height: 250,
                          child: ListView.builder(
                              // physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snap.data!.docs.length,
                              itemBuilder: (context, index) {
                                var productList =
                                    snap.data!.docs.map((category) {
                                  return Product.fromSnap(category);
                                }).toList();
                                Product product = productList[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => ItemPage(
                                          pageId: index,
                                          page: "Details",
                                          product: product,
                                        ));
                                  },
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => ItemPage(
                                                pageId: index,
                                                page: "Details",
                                                product: product,
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7),
                                          child: Container(
                                            width: 170,
                                            height: 225,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3),
                                                  )
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Image.network(
                                                          product.photo,
                                                          height: 130,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      product.title,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      product.address,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${product.price.toString()} FBu",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.black,
                                                          size: 26,
                                                        )
                                                      ],
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.blueGrey,
                        );
                }),

            // Category

            Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                children: const [
                  Text(
                    "Popular",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            //Recent post list

            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .where('quantity', isGreaterThan: 0)
                    .orderBy('quantity', descending: false)
                    .snapshots(),
                builder: (c, snapshot) {
                  return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                                Get.to(() => ItemPage(
                                      pageId: index,
                                      page: "Details",
                                      product: product,
                                    ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 380,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(product.title,
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            product.house,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            product.address,
                                            style: const TextStyle(
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
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.blueAccent,
                                            ),
                                            onRatingUpdate: (index) {},
                                          ),
                                          Text(
                                            "${product.price.toString()} FBU",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                      : const CircularProgressIndicator(
                          color: Colors.blueGrey,
                        );
                })
          ],
        ),
      ),
      //Drawer
      drawer: const DrawerWidget(),
    );
  }
}
