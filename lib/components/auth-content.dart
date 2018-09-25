import 'dart:convert';

import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:flutter/material.dart';

import '../model/config.dart';

class AuthContent extends StatefulWidget {
  @override
  AuthContentState createState() {
    return new AuthContentState();
  }
}

class AuthContentState extends State<AuthContent> {
  final TextEditingController emailInputController =
      new TextEditingController();
  final TextEditingController pwdInputController = new TextEditingController();

  void _tryToLogin(BuildContext context) async {
    final email = emailInputController.text;
    final pwd = pwdInputController.text;

    final resp = await KKHttpClient().post('', body: {email: email, pwd: pwd});
    final respJson = HttpResponse.fromJSON(json.decode(resp.body));

    if (respJson.status != 200) {
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(respJson.msg))
      );
      return;
    }

    AppConfig.jwtToken = respJson.data['token'];
    // TODO: update user profile

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authorization')),
      body: Center(
          child: Card(
              child: Stack(children: <Widget>[
        new _InputItem(inputController: emailInputController),
        new _InputItem(inputController: pwdInputController),
        RaisedButton(child: Text("submit"), onPressed: () { this._tryToLogin(context); })
      ]))),
    );
  }
}

class _InputItem extends StatelessWidget {
  const _InputItem({
    Key key,
    @required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: TextField(
        decoration: InputDecoration(labelText: "email"),
        controller: inputController,
        onChanged: (v) => inputController.text = v,
      ),
      padding: const EdgeInsets.only(bottom: 10.0),
    );
  }
}
