import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaage/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Stream<User?> get user => _auth.userChanges();

  String getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

//signin email pwd
  Future signinMailPwd(String mail, String pwd) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: mail, password: pwd);
      User? user = result.user;
      return Usermodel.fromUser(user!);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  Future updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } catch (exception) {
      print(exception);
    }
  }



// register mail pwd
  Future registerMailPwd(String mail, String pwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pwd);
      User? user = result.user;
      userCollection.add(
          Usermodel(postal: '', adresse: '', userid: user!.uid.toString(), date: '', ville: '', password: '', login: user.email.toString(), panier: [],)
          );
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out

  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
