import 'package:ClippingKK/model/httpResponse.dart';
import 'package:ClippingKK/pages/detail.dart';
import 'package:flutter/material.dart';

final titleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold
);

final contentStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w300
);


class SearchClippingResult extends StatelessWidget {
  const SearchClippingResult({
    Key key,
    @required this.result,
  }) : super(key: key);

  final ClippingItem result;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(child: Text(result.title, textAlign: TextAlign.left, style: titleStyle), margin: EdgeInsets.only(bottom: 10.0),),
              Text(result.content, textAlign: TextAlign.left, style: contentStyle,)
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) =>
                    DetailPage(item: result)));
      },
    );
  }
}
