import 'package:ClippingKK/model/httpResponse.dart';
import 'package:ClippingKK/pages/detail.dart';
import 'package:flutter/material.dart';

const _contentTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color.fromRGBO(0, 0, 0, 1.0),
);

const _titleTextStyle = TextStyle(
  fontSize: 16.0,
  color: Color.fromRGBO(0, 0, 0, 1.0),
);

class CardClipping extends StatelessWidget {
  final ClippingItem item;
  CardClipping({@required this.item});

  void _gotoDetail(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext ctx) => DetailPage(item: item)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this._gotoDetail(context),
      child: Card(
          margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  item.content,
                  style: _contentTextStyle
                ),
                Text(
                  '—— 【${item.title}】',
                  textAlign: TextAlign.right,
                  style: _titleTextStyle
                )
              ],
            ),
          )),
    );
  }
}
