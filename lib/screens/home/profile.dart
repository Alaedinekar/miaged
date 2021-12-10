import 'dart:async';

import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miaage/models/user.dart';
import 'package:miaage/models/vetement.dart';
import 'package:miaage/screens/home/detail.dart';

import 'package:miaage/services/database.dart';
import 'package:provider/provider.dart';

import '../../loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DatabaseService _db = DatabaseService();
  late Future<Usermodel?> usr;
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 10), () {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    usr = _db.getUser(user);
    String login = '';
    String password = '';
    String oldpassword = '';
    String adresse = '';
    String date = '';
    String postal = "";
    String ville = "";

    return Container(
        child: Column(children: [
      Expanded(
          child: FutureBuilder<Usermodel?>(
              future: usr,
              builder: (context, snapshot) {

                if (snapshot.hasData) {
                  final Usermodel? vet = snapshot.data;
                  login = vet!.login! ?? '';
                  password = vet.password! ?? '';
                  oldpassword = vet.password! ?? '';
                  adresse = vet.adresse! ?? '';
                  date = vet.date! ?? '';
                  postal = vet.postal! ?? '';
                  ville = vet.ville! ?? '';

                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: login,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    login = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,

                                  hintText: "Login",

                                  //make hint text
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'Login',
                                  //lable style
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                initialValue: password,
                                obscureText: true,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    password = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,

                                  hintText: "Password",

                                  //make hint text
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'Password',
                                  //lable style
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                initialValue: date,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    adresse = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  prefixIcon: Icon(
                                    Icons.cake,
                                    color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,

                                  hintText: "Anniversaire",

                                  //make hint text
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'Anniversaire',
                                  //lable style
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                initialValue: adresse,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    adresse = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  prefixIcon: Icon(
                                    Icons.home,
                                    color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,

                                  hintText: "Adresse",

                                  //make hint text
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'Adresse',
                                  //lable style
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                initialValue: ville,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    ville = value.toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,

                                  hintText: "ville",

                                  //make hint text
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'Ville',
                                  //lable style
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                key: Key(postal.toString()),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                initialValue: postal,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                onChanged: (value) {
                                  setState(() => postal = value);
                                },
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  //add prefix icon
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: Colors.grey,
                                  ),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: Colors.grey,
                                  hintText: "code postal",

                                  //make hint text
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),

                                  //create lable
                                  labelText: 'code postal',
                                  //lable style
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                var postData = Usermodel(
                                  login: login,
                                  userid: user!.uid,
                                  password: password,
                                  date: date,
                                  postal: postal,
                                  adresse: adresse,
                                  ville: ville,
                                  panier: [],
                                );
                                print('on update');
                                if(oldpassword != password){
                                  await _db.updateUser(postData,1).then(
                                          (value) =>
                                          setState(() {}));
                                }
                                else{
                                  await _db.updateUser(postData,0).then(
                                          (value) =>
                                          setState(() {}));
                                }



                              },
                              child: Text('Enregistrer les modifications'),
                            )
                          ],
                        );
                      });
                } else {
                  print(snapshot.data);
                }
                return RoundedLoadingButton(
                  child: Text('CHARGEMENT!',
                      style: TextStyle(color: Colors.white)),
                  controller: _btnController,
                  onPressed: _doSomething,
                );
              }))
    ]));
  }
}
