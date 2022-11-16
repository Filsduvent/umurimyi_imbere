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
import 'package:uburimyi_imbere/provider/user_model.dart' as model;

class AddAgentScreen extends StatefulWidget {
  const AddAgentScreen({Key? key}) : super(key: key);

  @override
  State<AddAgentScreen> createState() => _AddAgentScreenState();
}

class _AddAgentScreenState extends State<AddAgentScreen> {
  var usernameController = TextEditingController();
  var diplomacontroller = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();
  var phoneController = TextEditingController();
  var villeController = TextEditingController();
  var centreController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
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
                  left: Dimensions.height30 * 4,
                  right: Dimensions.height30 * 4,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimensions.height30 * 2,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: CircleAvatar(
                            radius:
                                Dimensions.radius30 * 2 + Dimensions.radius15,
                            backgroundImage: imageFile == null
                                ? AssetImage("assets/image/profile.png")
                                : Image.file(imageFile!).image,
                            backgroundColor: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // choose photo icon
                Positioned(
                  top: Dimensions.height45 * 4,
                  left: Dimensions.width45 * 5,
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
                                        controller: usernameController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Username")),
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
                                        controller: diplomacontroller,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Diploma level")),
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
                                        controller: emailController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email")),
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
                                        controller: countryController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Country")),
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
                                        controller: phoneController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Phone Number")),
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
                                        controller: villeController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Ville")),
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
                                        controller: centreController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.streetAddress,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Centre")),
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
                                        controller: passwordController,
                                        textInputAction: TextInputAction.done,
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password")),
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
                                        controller: confirmPassController,
                                        textInputAction: TextInputAction.done,
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Comfirm Password")),
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
                                    } else if (usernameController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the agent's username please",
                                          title: "username");
                                    } else if (diplomacontroller.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the agent's level capacity please",
                                          title: "diploma");
                                    } else if (emailController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the agent's email please",
                                          title: "Email");
                                    } else if (!GetUtils.isEmail(
                                        emailController.text)) {
                                      showCustomSnackBar(
                                          "Fill a valid  email please",
                                          title: "Valid email");
                                    } else if (countryController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the country field please",
                                          title: "country");
                                    } else if (phoneController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the agent's phone number please",
                                          title: "phone number");
                                    } else if (phoneController.text.length !=
                                        8) {
                                      showCustomSnackBar(
                                          "Wrong phone number format",
                                          title: "Phone number");
                                    } else if (int.parse(phoneController.text) <
                                        0) {
                                      showCustomSnackBar(
                                          "Phone number can't be negative",
                                          title: "Phone number");
                                    } else if (villeController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the agent's city please",
                                          title: "City");
                                    } else if (centreController.text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the center for the agent please",
                                          title: "city");
                                    } else if (passwordController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Fill the agent's password please",
                                          title: "Password");
                                    } else if (passwordController.text.length <
                                        6) {
                                      showCustomSnackBar(
                                          "Password can't be less than 6 characters",
                                          title: "Password valid");
                                    } else if (confirmPassController
                                        .text.isEmpty) {
                                      showCustomSnackBar(
                                          "Confirm the  password  please",
                                          title: "Confirm password");
                                    } else if (passwordController.text !=
                                        confirmPassController.text) {
                                      showCustomSnackBar("Password don't match",
                                          title: "Verification");
                                    } else {
                                      setState(() {
                                        _isLoaded = true;
                                      });
                                      UserCredential cred = await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                      String downloadUrl =
                                          await _uploadToStorage(imageFile!);

                                      model.User user = model.User(
                                          username: usernameController.text,
                                          diploma: diplomacontroller.text,
                                          email: emailController.text,
                                          country: countryController.text,
                                          phone: phoneController.text,
                                          ville: villeController.text,
                                          centre: centreController.text,
                                          password: passwordController.text,
                                          status: "Active",
                                          role: "Agent",
                                          profilePhoto: downloadUrl,
                                          uid: cred.user!.uid);

                                      await FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(cred.user!.uid)
                                          .set(user.toJson())
                                          .then((value) {
                                        Get.toNamed(
                                            RoutesHelper.getAdminMainScreen());
                                      });

                                      setState(() {
                                        _isLoaded = false;
                                      });
                                    }
                                  } catch (e) {
                                    showCustomSnackBar(
                                      e.toString(),
                                      title: "Creating Agent",
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
                                        "Add new agent",
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
