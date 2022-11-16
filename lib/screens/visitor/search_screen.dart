// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/provider/product_model.dart';
import 'package:uburimyi_imbere/screens/visitor/ItemPage.dart';
import '../../../../widgets/app_icon.dart';
import '../../routes/RoutesHelper.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/no_data_page.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  Future<QuerySnapshot>? productDocumentsList;
  String productTitleText = "";

  initSearchingPost(String textEntered) {
    productDocumentsList = FirebaseFirestore.instance
        .collection('Products')
        .where('title', isGreaterThanOrEqualTo: textEntered)
        .get();

    setState(() {
      productDocumentsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<QuerySnapshot>(
            future: productDocumentsList,
            builder: (context, AsyncSnapshot snap) {
              return Stack(
                children: [
                  // color cover back ground
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize,
                      color: Color(0xFFF5F5F3),
                    ),
                  ),

                  //Two buttons

                  Positioned(
                    top: Dimensions.height20 * 2,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesHelper.getInitial());
                            },
                            child: AppIcon(
                              icon: Icons.arrow_back_ios,
                              iconColor: Colors.blueGrey,
                            )),
                      ],
                    ),
                  ),

                  //The container with the number of items in firebase
                  Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        onChanged: (textEntered) {
                          setState(() {
                            productTitleText = textEntered;
                          });
                          initSearchingPost(textEntered);
                        },
                        decoration: InputDecoration(
                          hintText: "Search here...",

                          prefixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                initSearchingPost(productTitleText);
                              }),
                          // icon: IconButton(icon:Icons.search),
                          border: InputBorder.none,
                        ),
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
                              // top: Dimensions.height10 / 2
                              ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                topLeft: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white),

                          // the content of the white background

                          child: snap.hasData && snap.data!.docs.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 12.0,
                                                  mainAxisSpacing: 12.0,
                                                  mainAxisExtent: 280),
                                          itemCount: snap.data!.docs.length,
                                          itemBuilder: (_, index) {
                                            var productList =
                                                snap.data!.docs.map((drug) {
                                              return Product.fromSnap(drug);
                                            }).toList();
                                            Product product =
                                                productList[index];
                                            return product.quantity != 0
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.to(() => ItemPage(
                                                            pageId: index,
                                                            page: "Details",
                                                            product: product,
                                                          ));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16.0),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 1,
                                                              offset:
                                                                  const Offset(
                                                                      0, 2),
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                            )
                                                          ]),
                                                      child: Column(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16.0)),
                                                            child:
                                                                Image.network(
                                                              product.photo,
                                                              height: 170,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      product
                                                                          .title,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 6,
                                                                    ),
                                                                    Text(
                                                                      product
                                                                          .address,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            18,
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
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.red,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        const Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              Colors.black,
                                                                          size:
                                                                              26,
                                                                        )
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          8.0,
                                                                    ),
                                                                  ]))
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container();
                                          }),
                                    ),
                                  ),
                                )
                              : const NoDataPage(
                                  text: "No products found ",
                                  imgPath: "assets/image/product.jpg",
                                ))),
                ],
              );
            }));
  }
}
