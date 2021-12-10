import 'package:flutter/material.dart';
import 'package:miaage/models/vetement.dart';

import 'package:miaage/services/database.dart';

import '../../loading.dart';

class Detail extends StatelessWidget {
  final Vetement? vet;

  const Detail({Key? key, required this.vet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text(vet!.name),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            //Une image

            Container(
                height: 54.0,
                padding: EdgeInsets.all(12.0),
                child: Text(vet!.detail,
                    style: TextStyle(fontWeight: FontWeight.w700))),

            SizedBox(
              child: Image.network(vet!.imageUrl),
              height: 400,
              width: 400,
            ),

            Text(vet!.price.toString()),
            Text(vet!.detail),
            Text(vet!.size),
            Text(vet!.brand),
          ],
        ),
      ),
    );
  }
}
