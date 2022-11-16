// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String title;
  String photo;
  int price;
  String uid;
  String publishdate;
  String description;
  int quantity;
  String address;
  String house;

  Product({
    required this.id,
    required this.title,
    required this.photo,
    required this.price,
    required this.uid,
    required this.publishdate,
    required this.description,
    required this.quantity,
    required this.address,
    required this.house,
  });

  static Product fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Product(
        id: snap.id,
        title: snapshot['title'].toString(),
        photo: snapshot['photo'].toString(),
        price: snapshot['price'],
        uid: snapshot['uid'].toString(),
        publishdate: snapshot['publishdate'].toString(),
        description: snapshot['description'].toString(),
        quantity: snapshot['quantity'],
        address: snapshot['address'],
        house: snapshot['house']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "photo": photo,
        "price": price,
        "uid": uid,
        "publishdate": publishdate,
        "description": description,
        "quantity": quantity,
        "address": address,
        "house": house,
      };
}
