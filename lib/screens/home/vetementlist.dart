import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaage/models/user.dart';
import 'package:miaage/models/vetement.dart';
import 'package:miaage/screens/home/detail.dart';
import 'package:miaage/services/database.dart';
import 'package:provider/provider.dart';
import '../../loading.dart';

class Vetementlist extends StatefulWidget {
  @override
  _VetementlistState createState() => _VetementlistState();
}

class _VetementlistState extends State<Vetementlist> {
  final DatabaseService _db = DatabaseService();
  late Future<List<Vetement>> vetements;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late Future<Usermodel?> usr;

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    usr = _db.getUser(user);
    vetements = _db.getVetements();

    return Scaffold(
        body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder<List<Vetement>>(
              future: vetements,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final vet = snapshot.data;

                  return ListView.builder(
                      itemCount: vet!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        Vetement vetee = vet[index];

                        return Container(
                          child: Card(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text(vetee.name),
                                  subtitle: Text(vetee.detail),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(

                                          child: Image.network(vetee.imageUrl),
                                        width: 150.0,
                                      height: 100.0,)
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Taille '),
                                      Text(vetee.size),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Marque '),
                                      Text(vetee.brand),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text('Prix \$'),
                                      Text(vetee.price.toString()),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    TextButton(
                                      child: const Text('Ajouter au panier'),
                                      onPressed: () {
                                        _db.addToPanier(vet);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      child: const Text('Voir Detail'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Detail(vet: vetee)),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  print('y a r');
                }
                return RoundedLoadingButton(
                  child: Text('CHARGEMENT!',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: _doSomething,
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  Widget buildCard() => Container(
        width: 15,
        height: 15,
        color: Colors.red,
        child: Column(
          children: [
            Text('OUI'),
          ],
        ),
      );
}
