import 'package:ClippingKK/model/UserProfile.dart';
import 'package:ClippingKK/model/httpClient.dart';
import 'package:ClippingKK/pages/profile/user-info.dart';
import 'package:ClippingKK/repository/auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/appConfig.dart';

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

class ProfileContent extends StatelessWidget {
  final profileModel = UserProfile();

  ProfileContent() {
    AuthRepository().loadProfile(AppConfig.uid).then((profile) {
      this.profileModel.updateProfile(profile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserProfile>(
      model: profileModel,
      child: UserInfo()
    );

  }
}


class ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalAppConfig>(
      builder: (context, child, model) => model.jwtToken == "" ? _LoginFirstPage(onGotJWT: model.update) : ProfileContent()
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProfileState();
  }
}
