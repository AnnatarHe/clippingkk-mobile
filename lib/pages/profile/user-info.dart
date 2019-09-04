import 'package:ClippingKK/components/KKplaceholder.dart';
import 'package:ClippingKK/components/card-clipping.dart';
import 'package:ClippingKK/components/loading-item.dart';
import 'package:ClippingKK/model/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './basic-info.dart';

class ProfileContainer extends StatelessWidget {
  final UserProfile userProfile;
  final int count;

  ProfileContainer({ @required this.userProfile, @required this.count });

  @override
  Widget build(BuildContext context) {
    final user = this.userProfile.profile.user;
    final clippings = this.userProfile.profile.clippings;
    return Container(
      color: Color(0xfffafcff),
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BasicInfo(user: user, count: this.count),
          Divider(
            color: Color(0xffb0b1b9),
            height: 16.0,
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (BuildContext ctx, int index) {
                if (index > clippings.length) {
                  return Text('我也是有底线的！');
                }
                return CardClipping(item: clippings[index]);
              },
              itemCount: clippings.length,
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
        return model.profile == null ?
        LoadingItem(visible: true) :
        ProfileContainer(
          userProfile: model, count: model.profile.clippingsCount);
      },
    );
  }

}
