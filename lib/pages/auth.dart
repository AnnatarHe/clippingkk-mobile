import 'package:flutter/material.dart';
import '../components/auth-content.dart';

class AuthState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Authorization')),
        body: Center(
            child: Card(
                child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 250.0,
          width: MediaQuery.of(context).size.width * 0.9,
          child: AuthContent(),
        ))));
  }
}

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AuthState();
  }
}
