
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miaage/models/user.dart';
import 'package:miaage/models/vetement.dart';


import 'auth.dart';

class DatabaseService {
  final CollectionReference vetementCollection =
  FirebaseFirestore.instance.collection('vetements');

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('user');

  final AuthService _auth = AuthService();
  var listVetement = [];
  var panierData = [];

  Future addToPanier(List<Vetement?> newList) async {
    print('onn add');
    print(newList);
    List<String>  reflist = [];
    newList.forEach((e)=>{
      reflist.add(e!.firebaseRef)
    });
    try {
      var userId = await getUserDocId();
      await userCollection.doc(userId).update({"panier":reflist});
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future<List<Vetement>> getVetements() async {
    try {
      List<Vetement> vets = [];
      QuerySnapshot querySnapshot = await vetementCollection.get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          vets.add(Vetement.fromDocument(doc));
        }
      }
      return vets;
    } catch (exception) {
      print(exception);
      return [];
    }
  }





  Future<Usermodel?> getUser(usr) async {
    try {
      print(usr);
      late Usermodel usrdata;
      QuerySnapshot querySnapshot = await userCollection.get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          if (doc['userid'] == usr.uid) {
            usrdata = Usermodel.fromDocument(doc);
            return usrdata;
          }
          return null;
        }
      }
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future updateUser(Usermodel user,int newPass) async {

    print(newPass);
    print(user);
    var userDocId = await getUserDocId();
    print(userDocId);
    if(newPass == 0) {
      print('methode update sans mdp');
      try {
        await userCollection.doc(userDocId).update({
          "login": user.login,
          "userid": user.userid,
          "date": user.date,
          "ville": user.ville,
          "postal": user.postal,
          "adresse": user.adresse,
        });
        print('cest good');
        return true;
      } catch (exception) {
        print(exception);
        return false;
      }
    }
    else{
      try {
        await _auth.updatePassword(user.password ?? ' ');
        await userCollection.doc(userDocId).update({
          'login': user.login,
          'userid': user.userid,
          'password': user.password,
          'date': user.date,
          'ville': user.ville,
          'postal': user.postal,
          'adresse': user.adresse,
        });
        return true;
      } catch (exception) {
        print(exception);
        return false;
      }
    }
  }

  Future getUserDocId() async {
    try {
      String userDocId = "";
      await userCollection
          .where('userid', isEqualTo: _auth.getCurrentUserId())
          .get()
          .then((value) =>
      {
        if (value.docs.isNotEmpty) {userDocId = value.docs[0].id}
      });
      return userDocId;
    } catch (exception) {
      print(exception);
      return null;
    }
  }




}
