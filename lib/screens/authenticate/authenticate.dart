import 'package:flutter/material.dart';
import 'package:miaage/screens/authenticate/register.dart';
import 'package:miaage/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool ShowSignin = true;

  void toggleViews() {
    setState(() => {this.ShowSignin = !ShowSignin});
  }

  @override
  Widget build(BuildContext context) {
    if (ShowSignin) {
      return SignIn(toggleViews: toggleViews);
    } else {
      return Register(toggleViews: toggleViews);
    }
  }
}
