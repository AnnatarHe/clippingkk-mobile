import 'package:ClippingKK/components/card-clipping.dart';
import 'package:ClippingKK/components/loading-item.dart';
import 'package:ClippingKK/model/appConfig.dart';
import 'package:ClippingKK/repository/clippings.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/model/httpResponse.dart';

class BookDetailPage extends StatelessWidget {
  final KKBookInfo bookInfo;

  const BookDetailPage({Key key, this.bookInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = Size(100, 150);
    return Scaffold(
      appBar: AppBar(
        title: Text(bookInfo.title),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _bookCaption(bookInfo: bookInfo, imageSize: imageSize),
            Divider(color: Colors.black38),
            Expanded(
              flex: 1,
              child: _Clippings(bookInfo: bookInfo, userid: AppConfig.uid),
            )
          ],
        ),
      ),
    );
  }
}

class _Clippings extends StatefulWidget {
  final KKBookInfo bookInfo;
  final int userid;

  const _Clippings({Key key, this.bookInfo, this.userid}) : super(key: key);

  @override
  _ClippingsState createState() => _ClippingsState();
}

class _ClippingsState extends State<_Clippings> {
  ScrollController _listViewController = new ScrollController();

  bool _loading = false;
  bool _hasMore = true;
  int _offset = 0;

  List<ClippingItem> _clippingItems = [];

  @override
  void initState() {
    super.initState();
    _listViewController.addListener(this._listViewLoadMore);
    this._loadData();
  }

  void _listViewLoadMore() {
    if (_listViewController.position.pixels ==
        _listViewController.position.maxScrollExtent) {
      this._loadData();
    }
  }

  @override
  void dispose() {
    _listViewController.removeListener(this._listViewLoadMore);
    _listViewController.dispose();
    super.dispose();
  }

  Future<void> _loadData() {
    if (!_hasMore) {
      Scaffold.of(this.context).showSnackBar(SnackBar(
        content: Text("没有更多啦~"),
        action: SnackBarAction(
            label: "top",
            onPressed: () {
              _listViewController.animateTo(0.0,
                  duration: Duration(milliseconds: 350),
                  curve: Curves.easeInOut);
            }),
      ));
      return Future.value(null);
    }

    if (_loading) {
      return Future.value(null);
    }

    setState(() {
      _loading = true;
    });

    return ClippingsAPI()
        .getClippingsByBook(
            this.widget.userid, this.widget.bookInfo.doubanId, _offset)
        .then((result) {
      setState(() {
        _loading = false;
        _hasMore = result.length != 0;
        _offset += 20;
        _clippingItems.addAll(result);
      });
      return Future.value(null);
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
      return Future.error(err);
    });
  }

  Future<void> _onRefresh() {
    setState(() {
      _clippingItems.clear();
      _offset = 0;
      _hasMore = true;
    });

    return this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
          controller: _listViewController,
          itemCount: _clippingItems.length,
          itemBuilder: (ctx, index) {
            if (index < _clippingItems.length) {
              return CardClipping(item: _clippingItems[index]);
            }
            return LoadingItem(
                visible: _loading && this._clippingItems.length > 0);
          },
        ),
        onRefresh: this._onRefresh);
  }
}

class _bookCaption extends StatelessWidget {
  const _bookCaption({
    Key key,
    @required this.bookInfo,
    @required this.imageSize,
  }) : super(key: key);

  final KKBookInfo bookInfo;
  final Size imageSize;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: <Widget>[
              Hero(
                  tag: "book-detail-tag-" + bookInfo.id.toString(),
                  child: Image.network(bookInfo.image,
                      width: imageSize.width, height: imageSize.height)),
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            bookInfo.title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            bookInfo.author,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          Text(
                            bookInfo.summary,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w200,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                          ),
                        ],
                      )))
            ],
          )),
    );
  }
}
