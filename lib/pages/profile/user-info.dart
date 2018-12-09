import 'package:ClippingKK/components/KKplaceholder.dart';
import 'package:ClippingKK/model/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserProfile>(
      builder: (context, child, model) {
        return model.profile == null ? Placeholder() : Text(model.profile.user.name);
      },
    );
  }

}
