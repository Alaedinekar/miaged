import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Usermodel {
  late String? login;
  late String? password;
  late String? adresse;
  late String? postal;
  late String? date;
  late String? ville;
  late String? userid;
  late List<dynamic?> panier;

  Usermodel({
    required this.login,
    required this.userid,
    required this.password,
    required this.date,
    required this.ville,
    required this.postal,
    required this.adresse,
    required this.panier,
  });

  factory Usermodel.fromUser(User usrr) {
    print('factory user auth');
    print(usrr);
    Usermodel usr = Usermodel(
      login: usrr.email,
      userid: usrr.uid,
      password: '',
      date: '',
      postal: '',
      adresse: '',
      ville: '',
      panier: [],
    );
    return usr;
  }

  factory Usermodel.fromDocument(QueryDocumentSnapshot element) {
    Usermodel usr = Usermodel(
      login: element['login'] ?? ' ',
      userid: element['userid'] ?? ' ',
      password: element['password'] ?? ' ',
      date: element['date'] ?? ' ',
      postal: element['postal'] ?? ' ',
      adresse: element['adresse'] ?? ' ',
      ville: element['ville'] ?? ' ',
      panier: element['panier'] ?? [],
    );

    return usr;
  }
}
