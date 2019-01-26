import 'package:flutter/material.dart';
import 'package:ClippingKK/styles/profile.dart' as profileStyle;
import 'package:ClippingKK/model/httpClient.dart' as model;

class BasicInfo extends StatelessWidget {
  final model.User user;

  BasicInfo({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Image.network(
              user.avatar,
              width: 100,
              height: 100,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: <Widget>[
                  Text(user.name, style: profileStyle.profileUsernameStyle), 
                  Text(user.email)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
