import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaage/models/user.dart';
import 'package:miaage/models/vetement.dart';

import 'package:miaage/services/database.dart';
import 'package:provider/provider.dart';
import '../../loading.dart';
import 'detail.dart';

class Panier extends StatefulWidget {
  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  final DatabaseService _db = DatabaseService();
  late Future<List<Vetement>> vetements;
  late Future<Usermodel?> usr;
  int res = 0;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    print('on build panier');
    vetements = _db.getVetements();

    usr = _db.getUser(user);

    return Scaffold(
        body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

          Expanded(
              child: FutureBuilder<Usermodel?>(
                  future: usr,
                  builder: (context, snapshot) {
                    print('on est dans le panier avant');
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      var vet = snapshot.data;

                      print('on est dans le panier');
                      print(vet);
                      return FutureBuilder<List<Vetement>?>(
                          future: vetements,
                          builder: (context, snap) {
                            if (snap.hasData) {
                              List<Vetement?> pan =
                                  getVetementFromPanier(snap.data, vet);
                              res = getSomme(pan);
                              return ListView.builder(
                                  itemCount: pan.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return Column(children: [
                                      BottomAppBar(
                                        child: Text("PRIX TOTAL = ${res.toString()} euro"),
                                      ),
                                      Card(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: SizedBox(
                                                  height: 100.0,
                                                  width: 100.0,
                                                  // fixed width and height
                                                  child: Image.network(
                                                      pan[index]!.imageUrl)),
                                              title: Text(pan[index]!.name),
                                              subtitle: Text(pan[index]!.name),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('Taille '),
                                                  Text(pan[index]!.size),
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('Marque '),
                                                  Text(pan[index]!.brand),
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text('Prix \$'),
                                                  Text(pan[index]!
                                                      .price
                                                      .toString()),
                                                ]),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[

                                                IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                  ),
                                                  iconSize: 50,
                                                  color: Colors.red,
                                                  splashColor: Colors.purple,
                                                  onPressed: () {
                                                    pan.remove(pan[index]);
                                                    _db.addToPanier(pan).then(
                                                            (value) =>
                                                            setState(() {}));
                                                  },
                                                ),

                                                const SizedBox(width: 8),
                                                TextButton(
                                                  child:
                                                      const Text('Voir Detail'),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Detail(
                                                                vet: pan[index],
                                                              )),
                                                    );
                                                  },
                                                ),
                                                const SizedBox(width: 8),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]);
                                  });
                            } else {
                              return Text('PANIER VIDE');
                            }
                            return Text('PANIER VIDE');
                          });
                    } else {
                      return Text('PANIER VIDE');
                    }
                  })),

        ])));
  }
}

int getSomme(List<Vetement?> li) {
  int res = 0;
  li.forEach((element) {
    res += element!.price;
  });
  return res;
}

List<Vetement> getVetementFromPanier(List<Vetement>? vetli, Usermodel? usr) {
  List<Vetement> res = [];
  for (var i = 0; i < vetli!.length; i++) {
    if (usr!.panier.contains(vetli[i].firebaseRef)) {
      res.add(vetli[i]);
    }
  }
  return res;
}
