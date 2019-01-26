import 'package:flutter/material.dart';
import 'package:ClippingKK/styles/clipping.dart' as styles;

class ClippingContentText extends StatelessWidget {
  final String content;
  final String author;

  ClippingContentText({@required this.content, this.author});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(this.content, style: styles.ContentTextStyle),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(this.author, style: styles.TitleTextStyle),
          )
        ],
      ),
    );
  }
}
