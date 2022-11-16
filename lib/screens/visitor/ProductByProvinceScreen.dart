// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uburimyi_imbere/provider/product_model.dart';

import 'package:uburimyi_imbere/provider/province_model.dart';
import 'package:uburimyi_imbere/screens/visitor/ItemPage.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/no_data_page.dart';

class ProductByProvinceScreen extends StatefulWidget {
  final int pageId;
  final String page;
  final Province province;
  const ProductByProvinceScreen(
      {Key? key,
      required this.pageId,
      required this.page,
      required this.province})
      : super(key: key);

  @override
  State<ProductByProvinceScreen> createState() =>
      _ProductByProvinceScreenState();
}

class _ProductByProvinceScreenState extends State<ProductByProvinceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Products from ${widget.province.name}',
            style: const TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              child: AppIcon(
                icon: Icons.arrow_back_ios,
                backgroundColor: Colors.blueGrey,
                iconColor: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Products')
                .where('address', isEqualTo: widget.province.name)
                .snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? SingleChildScrollView(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12.0,
                                      mainAxisSpacing: 12.0,
                                      mainAxisExtent: 280),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                var productList =
                                    snapshot.data!.docs.map((pro) {
                                  return Product.fromSnap(pro);
                                }).toList();
                                Product product = productList[index];
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
                                                  BorderRadius.circular(16.0),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 1,
                                                  offset: const Offset(0, 2),
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                )
                                              ]),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0)),
                                                child: Image.network(
                                                  product.photo,
                                                  height: 170,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          product.title,
                                                          style:
                                                              const TextStyle(
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
                                                          style:
                                                              const TextStyle(
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
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              color:
                                                                  Colors.black,
                                                              size: 26,
                                                            )
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 8.0,
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
                      text: "No Product found ",
                      imgPath: "assets/image/product.jpg",
                    );
            }));
  }
}
