import 'package:flutter/material.dart';
import '../model/appConfig.dart';

class _LoginFirstPage extends StatelessWidget {
  void Function(String token) onGotJWT;

  _LoginFirstPage({ this.onGotJWT });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Card(
          child: IconButton(
            icon: Icon(Icons.lock),
            onPressed: () => onPressBtnPressed(context),
          ),
        ),
      )
    );
  }

  void onPressBtnPressed(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/auth');
    print(result);
    onGotJWT(result);
  }
}

class ProfileState extends State<ProfilePage> {

  String token = "";

  void onGotToken(String token) {
    AppConfig.jwtToken = token;
    setState(() {
      this.token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.token == "") {
      return _LoginFirstPage(onGotJWT: onGotToken);
    }
    // TODO: implement build
    return Center(child: Text('squre'));
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileState();
  }
}
