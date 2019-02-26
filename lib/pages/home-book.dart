import 'package:ClippingKK/components/book-item.dart';
import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/repository/clippings.dart';
import 'package:ClippingKK/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/components/loading-item.dart';
import 'package:ClippingKK/model/appConfig.dart';

class HomeBooksPage extends StatefulWidget {
  @override
  _HomeBooksPageState createState() => _HomeBooksPageState();
}

class _HomeBooksPageState extends State<HomeBooksPage> {
  bool _loading = false;
  int _offset = 0;
  bool _hasMore = true;
  List<KKBookInfo> _books = [];

  ScrollController _listViewController = ScrollController();

  @override
  void initState() {
    super.initState();
    _listViewController.addListener(this._listViewLoadMore);

    _loadData();
  }

  void _listViewLoadMore() {
    if (_listViewController.position.pixels ==
        _listViewController.position.maxScrollExtent) {
      this._loadData();
    }
  }

  void dispose() {
    _listViewController.removeListener(this._listViewLoadMore);
    _listViewController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
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

    final result = await ClippingsAPI().getBooks(AppConfig.uid, _offset);
    if (!this.mounted) {
      return Future.value(null);
    }
    setState(() {
      _loading = false;
      _offset += 20;
      _hasMore = result.length > 0;
      _books.addAll(result);
    });

    return result;
  }

  Future<void> _onRefresh() {
    setState(() {
      _books.clear();
      _offset = 0;
      _hasMore = true;
    });

    return this._loadData();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    KKLogger().getLogger().fine(this._books.length);

    return new Scaffold(
      body: Container(
        color: Color(0xfffafcff),
        child: RefreshIndicator(
            child: ListView.builder(
              controller: _listViewController,
              itemCount: this._books.length + 1,
              itemBuilder: (ctx, index) {
                if (index < _books.length) {
                  return BookItem(book: _books[index]);
                }
                return LoadingItem(visible: _loading && this._books.length > 0);
              },
            ),
            onRefresh: this._onRefresh),
      ),
    );
  }
}
