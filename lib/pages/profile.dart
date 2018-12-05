import 'package:ClippingKK/model/httpClient.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/appConfig.dart';

class _LoginFirstPage extends StatelessWidget {
  void Function(String token, int uid) onGotJWT;

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
    final User result = await Navigator.pushNamed(context, '/auth');
    onGotJWT(result.jwtToken, result.id);
  }
}
class ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalAppConfig>(
      builder: (context, child, model) => model.jwtToken == "" ? _LoginFirstPage(onGotJWT: model.update) : Center(child: Text('squre'))
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileState();
  }
}
