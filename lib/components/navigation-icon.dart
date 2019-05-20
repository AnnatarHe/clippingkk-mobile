import 'package:ClippingKK/model/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NavigationRightIcon extends StatelessWidget {
  Widget _buttonBuilder(
    BuildContext context,
    Widget child,
    GlobalAppConfig model
  ) {
    final logged = model.jwtToken != '';
    IconData icon = logged ? Icons.settings : Icons.directions_run;
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        Navigator.pushNamed(context, logged ? '/setting' : '/auth');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalAppConfig>(builder: this._buttonBuilder);
  }
}
