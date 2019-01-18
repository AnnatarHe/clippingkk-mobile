import 'package:ClippingKK/components/KKplaceholder.dart';
import 'package:ClippingKK/model/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './basic-info.dart';

class ProfileContainer extends StatelessWidget {
  final UserProfile userProfile;
  ProfileContainer({ @required this.userProfile });

  @override
  Widget build(BuildContext context) {
    final user = this.userProfile.profile.user;
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BasicInfo(user: user),
          Divider(
            color: Color(0xffb0b1b9),
            height: 16.0,
          ),
          Text("TODO")
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
