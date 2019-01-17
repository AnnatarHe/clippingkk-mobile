import 'package:ClippingKK/components/KKplaceholder.dart';
import 'package:ClippingKK/model/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileContainer extends StatelessWidget {
  final UserProfile userProfile;
  ProfileContainer({ @required this.userProfile });

  @override
  Widget build(BuildContext context) {
    final user = this.userProfile.profile.user;
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: <Widget>[
          Card(
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
                      children: <Widget>[
                        Text(user.name),
                        Text(user.email)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}

class UserInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserProfile>(
      builder: (context, child, model) {
        return model.profile == null ? Placeholder() : ProfileContainer(userProfile: model);
      },
    );
  }

}
