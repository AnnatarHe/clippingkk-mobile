import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {

  final int tabIndex;

  AppBarTitle({ @required this.tabIndex });

  String getTitle() {
    switch (tabIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Square';
      case 2:
        return 'Profile';
      default:
        return 'Unknow';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(getTitle());
  }

}