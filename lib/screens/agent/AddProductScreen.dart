// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, sort_child_properties_last, prefer_typing_uninitialized_variables, unused_field, prefer_final_fields, avoid_unnecessary_containers, use_build_context_synchronously, file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uburimyi_imbere/routes/RoutesHelper.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/show_custom_snackbar.dart';
import 'package:uburimyi_imbere/provider/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  var titleController = TextEditingController();
  var addresscontroller = TextEditingController();
  var houseController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();
  var descriptionController = TextEditingController();
  File? imageFile;
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoaded
          ? Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                        width: double.maxFinite,
                        height: Dimensions.popularFoodImgSize / 1.2,
                        color: Colors.grey.withOpacity(0.1))),

                Positioned(
                  top: Dimensions.height20 * 2,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: AppIcon(
                            icon: Icons.arrow_back_ios,
                            iconColor: Colors.white,
                            backgroundColor: Colors.red,
                          )),
                    ],
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                      width: double.maxFinite,
                      height: Dimensions.popularFoodImgSize / 1.2,
                      //color: Colors.grey.withOpacity(0.1),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageFile == null
                                ? const AssetImage("assets/image/product.jpg")
                                : Image.file(imageFile!).image,
                          ))),
                ),

                // Positioned(
                //   left: Dimensions.height30 * 4,
                //   right: Dimensions.height30 * 4,
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //       top: Dimensions.height30 * 2,
                //     ),
                //     child: Center(
                //       child: Padding(
                //         padding: const EdgeInsets.all(10),
                //         child: Container(
                //           child: CircleAvatar(
                //             radius:
                //                 Dimensions.radius30 * 2 + Dimensions.radius15,
                //             backgroundImage: imageFile == null
                //                 ? AssetImage("assets/image/profile.png")
                //                 : Image.file(imageFile!).image,
                //             backgroundColor: Colors.blueGrey,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                //The back button

                // choose photo icon
                Positioned(
                  top: Dimensions.height45 * 4.5,
                  left: Dimensions.width45 * 7.5,
                  child: GestureDetector(
                    onTap: () => _showImageDialog(),
                    child: AppIcon(
                      icon: Icons.add_a_photo,
                      backgroundColor: Colors.blueGrey,
                      iconColor: Colors.white,
                      iconSize: Dimensions.height30,
                      size: Dimensions.height30 * 2,
                    ),
                  ),
                ),

                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: (Dimensions.popularFoodImgSize - 20) / 1.2,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20),
                      ),
                      color: Colors.white,
                    ),

                    //All content field
                    child: Column(children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                        controller: titleController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Name of the product")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                        controller: addresscontroller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Address of agence")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                        controller: houseController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                "Name of the house provider")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                        controller: priceController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Price")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                        controller: quantityController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Quantity")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextField(
                                        controller: descriptionController,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "description")),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    if (imageFile == null) {
                                      showCustomSnackBar("Choose an image",
                                          title: "Image");
                                    } else if (titleController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the title of the product",
                                          title: "title");
                                    } else if (addresscontroller.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the address of the agence please",
                                          title: "address");
                                    } else if (houseController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the house provider name ",
                                          title: "address");
                                    } else if (priceController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the price please",
                                          title: "price");
                                    } else if (int.parse(
                                            priceController.text) <=
                                        0) {
                                      showCustomSnackBar(
                                          "The price must be greater than 0",
                                          title: "price");
                                    } else if (quantityController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the quantity please",
                                          title: "quantity");
                                    } else if (int.parse(
                                            quantityController.text) <=
                                        0) {
                                      showCustomSnackBar(
                                          "The quantity must be greater than 0",
                                          title: "quantity");
                                    } else if (descriptionController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the the description of the product please",
                                          title: "phone number");
                                    } else {
                                      setState(() {
                                        _isLoaded = true;
                                      });

                                      String uid = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      String downloadUrl =
                                          await _uploadToStorage(imageFile!);

                                      Product product = Product(
                                          id: DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                          title: titleController.text,
                                          photo: downloadUrl,
                                          price:
                                              int.parse(priceController.text),
                                          uid: uid,
                                          publishdate:
                                              DateTime.now().toString(),
                                          description:
                                              descriptionController.text,
                                          quantity: int.parse(
                                              quantityController.text),
                                          address: addresscontroller.text,
                                          house: houseController.text);

                                      await FirebaseFirestore.instance
                                          .collection('Products')
                                          .doc(DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString())
                                          .set(product.toJson())
                                          .then((value) {
                                        Get.toNamed(
                                            RoutesHelper.getAgentMainScreen());
                                      });

                                      setState(() {
                                        _isLoaded = false;
                                      });
                                    }
                                  } catch (e) {
                                    showCustomSnackBar(
                                      e.toString(),
                                      title: "Creating Products",
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Add a product",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.screenHeight * 0.05,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
              color: Colors.blueGrey,
            )),
    );
  }

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: BigText(
              text: "Please select an option",
              color: Colors.blueGrey,
              size: Dimensions.font20,
            ),
            children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.camera_alt),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Camera",
                      color: Colors.blueGrey,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () {
                  _getFromCamera();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.image),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Gallery",
                      color: Colors.blueGrey,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () {
                  _getFromGallery();
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    const Icon(Icons.cancel),
                    const Padding(padding: EdgeInsets.all(7.0)),
                    BigText(
                      text: " Cancel",
                      color: Colors.blueGrey,
                      size: Dimensions.font16,
                    ),
                  ],
                ),
                onPressed: () => Get.back(),
              ),
            ],
          );
        });
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('AgentPics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
