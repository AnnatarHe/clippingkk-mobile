import 'package:ClippingKK/model/httpResponse.dart';
import 'package:flutter/material.dart';




class CardClipping extends StatelessWidget {

  final ClippingItem item;

  CardClipping({ @required this.item });

  @override
  Widget build(BuildContext context) {
    print(item);
    return Card(child: Column(
      children: <Widget>[
        Text(item.content)
      ]
    ));
  }
}