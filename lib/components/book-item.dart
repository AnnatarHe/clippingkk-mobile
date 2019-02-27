import 'package:ClippingKK/pages/book-detail.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:ClippingKK/model/doubanBookInfo.dart';

class BookItem extends StatelessWidget {
  final KKBookInfo book;

  BookItem({@required this.book});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
      .of(context)
      .size
      .width - 100;
    final height = 450.0;
    return Container(
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext ctx) =>
              BookDetailPage(bookInfo: this.book))
          );
        },
        child: Stack(fit: StackFit.expand, children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(const Radius.circular(8.0)),
            child: Container(
              child: Hero(
                tag: "book-detail-tag-${book.id.toString()}",
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                )
              )
            )),
          Positioned(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    book.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    book.author,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: const Radius.circular(8.0),
                  bottomLeft: const Radius.circular(8.0),
                ),
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            bottom: 0.0,
            left: 0,
            width: width + 80,
          )
        ])),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black38,
          offset: Offset.zero,
          blurRadius: 8.0,
        )
      ]),
      width: width,
      height: height,
    );
  }
}
