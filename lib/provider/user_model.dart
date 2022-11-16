// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String diploma;
  String email;
  String country;
  String phone;
  String ville;
  String centre;
  String password;
  String status;
  String role;
  String profilePhoto;
  String uid;

  User({
    required this.username,
    required this.diploma,
    required this.email,
    required this.country,
    required this.phone,
    required this.ville,
    required this.centre,
    required this.password,
    required this.status,
    required this.role,
    required this.profilePhoto,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "diploma": diploma,
        "email": email,
        "country": country,
        "phone": phone,
        "ville": ville,
        "centre": centre,
        "password": password,
        "status": status,
        "role": role,
        "profilePhoto": profilePhoto,
        "uid": uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      diploma: snapshot['diploma'],
      email: snapshot['email'],
      country: snapshot['country'],
      phone: snapshot['phone'],
      ville: snapshot['ville'],
      centre: snapshot['centre'],
      password: snapshot['password'],
      status: snapshot['status'],
      role: snapshot['role'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
    );
  }

  static User fromMaps(Map<String, dynamic> data) {
    return User(
      username: data['username'],
      diploma: data['diploma'],
      email: data['email'],
      country: data['country'],
      phone: data['phone'],
      ville: data['ville'],
      centre: data['centre'],
      password: data['password'],
      status: data['status'],
      role: data['role'],
      profilePhoto: data['profilePhoto'],
      uid: data['uid'],
    );
  }
}
