import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {

  final bool visible;
  LoadingItem({ @required this.visible });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Opacity(
            opacity: visible ? 1.0 : 0.0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            )));
  }
}
