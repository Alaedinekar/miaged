import 'package:cloud_firestore/cloud_firestore.dart';

class Vetement {
  late String name;
  late String detail;
  late int price;
  late String imageUrl;
  late String size;
  late String brand;
  late String userid;
  late List<dynamic> tags;
  late String firebaseRef;

  Vetement({
    required this.firebaseRef,
    required this.userid,
    required this.price,
    required this.name,
    required this.detail,
    required this.imageUrl,
    required this.size,
    required this.brand,
    required this.tags,
  });


  factory Vetement.fromDocument(DocumentSnapshot element) {
    Vetement vet = new Vetement(firebaseRef: element['firebaseRef'],
        userid: element['userid'],
        price: element['price'],
        name: element['name'],
        detail: element['detail'],
        imageUrl: element['imageUrl'],
        size: element['size'],
        brand: element['brand'],
        tags: element['tags']);
    return vet;
  }


}