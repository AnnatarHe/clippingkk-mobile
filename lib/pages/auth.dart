import 'package:flutter/material.dart';
import '../components/auth-content.dart';

class AuthState extends State<AuthPage> {
  @override
    Widget build(BuildContext context) {

      final String bgImage = "https://kindle.annatarhe.com/coffee-d3ec79a0efd30ac2704aa2f26e72cb28.jpg";

      return Container(
        decoration: BoxDecoration(image: DecorationImage(
          image: NetworkImage(bgImage),
          fit: BoxFit.cover
        )),
        child: AuthContent(),
      );
    }
}

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AuthState();
  }
}