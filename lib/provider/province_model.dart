// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Province {
  String id;
  String name;

  Province({
    required this.id,
    required this.name,
  });

  static Province fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Province(
      id: snap.id,
      name: snapshot['name'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
