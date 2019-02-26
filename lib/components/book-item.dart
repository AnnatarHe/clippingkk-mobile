import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:ClippingKK/model/doubanBookInfo.dart';

class BookItem extends StatelessWidget {
  final KKBookInfo book;

  BookItem({@required this.book});

  @override
  Widget build(BuildContext context) {
    // TODO: update book item
    return Stack(fit: StackFit.expand, children: <Widget>[
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(book.image), fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
            )),
      ),
      Container(child: Text(book.title))
    ]);
  }
}
