import 'package:flutter/material.dart';

final _contentStyle = TextStyle(

);

class ClippingContentText extends StatelessWidget {
  final String content;

  ClippingContentText({ @required this.content });

  @override
  Widget build(BuildContext context) {
    return Text(this.content, style: _contentStyle);
  }
}