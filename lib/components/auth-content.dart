import 'dart:convert';
import 'dart:developer';

import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/appConfig.dart';

class AuthContent extends StatefulWidget {
  @override
  AuthContentState createState() {
    return new AuthContentState();
  }
}

class AuthContentState extends State<AuthContent> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController pwdInputController = TextEditingController();
  final _keychain = FlutterSecureStorage();

  void _tryToLogin(BuildContext context) async {
    final email = emailInputController.text;
    final pwd = pwdInputController.text;
    if (email.isEmpty || pwd.isEmpty) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("email or password are empty")));
      return;
    }

    final resp = await KKHttpClient().post('${AppConfig.httpPrefix}/auth/login',
        body: {email: email, pwd: pwd});
    final respJson = HttpResponse.fromJSON(json.decode(resp.body));

    if (respJson.status != 200) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(respJson.msg)));
      return;
    }

    final String token = respJson.data["token"];

    AppConfig.jwtToken = token;
    this._keychain.write(key: "jwt", value: token);

    log(token);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      _InputItem(
            inputController: emailInputController, label: _inputType.email),
      _InputItem(
            inputController: pwdInputController, label: _inputType.pwd),
      Expanded(
          child: MaterialButton(
              minWidth: 300.0,
              color: Theme.of(context).primaryColor,
              child: Text("Submit", style: TextStyle(color: Colors.white)),
              onPressed: () {
                this._tryToLogin(context);
              }))
    ]);
  }
}

enum _inputType { email, pwd }

class _InputItem extends StatelessWidget {
  const _InputItem({
    Key key,
    @required this.inputController,
    @required this.label,
  }) : super(key: key);

  final TextEditingController inputController;
  final _inputType label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: TextField(
        decoration: InputDecoration(
          labelText: this.label == _inputType.email ? "Email" : "Password",
          prefixIcon:
              Icon(this.label == _inputType.email ? Icons.email : Icons.lock),
        ),
        controller: inputController,
        onChanged: (v) => inputController.text = v,
      ),
      padding: const EdgeInsets.only(bottom: 10.0),
    );
  }
}
