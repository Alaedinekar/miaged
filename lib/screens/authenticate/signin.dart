import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miaage/services/auth.dart';

import '../../delayed_effect.dart';
import '../../loading.dart';
import 'register.dart';

class SignIn extends StatefulWidget {
  final Function toggleViews;

  const SignIn({required this.toggleViews});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String mail = '';
  String pwd = '';
  String error = '';
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }
  @override
  Widget build(BuildContext context) {
    return loading ?  RoundedLoadingButton(
      child: Text('CHARGEMENT!', style: TextStyle(color: Colors.white)),
      controller: _btnController,
      onPressed: _doSomething,
    ) : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Connexion MIAGED'),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () {
                  widget.toggleViews();
                },
                icon: Icon(Icons.person),
                label: Text('Creer un compte'))
          ],
        ),
        body: Center(
          child: Column(children: [
            //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            DelayedAnimation(delay: 1000, child: FlutterLogo(size: 200)),
            SizedBox(height: 20),

            DelayedAnimation(
              delay: 1000,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Login'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a email' : null,
                          onChanged: (val) {
                            setState(() => mail = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Password'),
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => pwd = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.pink[400], // background
                            ),
                            onPressed: () async {
                              setState(() => loading = true);

                              if (_formKey.currentState!.validate()) {
                                print('valid');
                                dynamic res =
                                    await _auth.signinMailPwd(mail, pwd);

                                if (res == null) {
                                  setState(() => error = 'error signin');
                                  loading = false;
                                }
                              }
                            },
                            child:
                            Text(
                              'Se connecter',
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0))
                      ],
                    ),
                  )),
            )
          ]),
        ));
  }
}
