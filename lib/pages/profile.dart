import 'package:flutter/material.dart';
import '../model/config.dart';

class _LoginFirstPage extends StatelessWidget {
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
    ));
  }

  void onPressBtnPressed(BuildContext context) {
    Navigator.pushNamed(context, '/auth');
  }
}

class ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (AppConfig.jwtToken == "") {
      return _LoginFirstPage();
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
