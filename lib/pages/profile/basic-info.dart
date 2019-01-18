import 'package:flutter/material.dart';
import 'package:ClippingKK/model/httpClient.dart' as model;

class BasicInfo extends StatelessWidget {
  final model.User user;

  BasicInfo({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Image.network(
              user.avatar,
              width: 100,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: <Widget>[Text(user.name), Text(user.email)],
              ),
            )
          ],
        ),
      ),
    );
  }
}
