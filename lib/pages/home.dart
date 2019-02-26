import 'package:ClippingKK/components/card-clipping.dart';
import 'package:ClippingKK/components/loading-item.dart';
import 'package:ClippingKK/repository/clippings.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/model/httpResponse.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

const _take_pre_page = 10;

class _MyHomePageState extends State<HomePage>
  with AutomaticKeepAliveClientMixin<HomePage> {
  List<ClippingItem> _clippingItems = [];
  ScrollController _listViewController = ScrollController();

  bool _loading = false;
  bool _hasMore = true;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _listViewController.addListener(this._listViewLoadMore);
    loadData();
  }

  void _listViewLoadMore() {
    if (_listViewController.position.pixels ==
      _listViewController.position.maxScrollExtent) {
      this.loadData();
    }
  }


  @override
  void dispose() {
    _listViewController.removeListener(this._listViewLoadMore);
    _listViewController.dispose();
    super.dispose();
  }

  Future<void> loadData() {
    if (!_hasMore) {
      Scaffold.of(this.context).showSnackBar(
        SnackBar(content: Text("没有更多啦~"),
          action: SnackBarAction(label: "top", onPressed: () {
            _listViewController.animateTo(
              0.0, duration: Duration(milliseconds: 350),
              curve: Curves.easeInOut);
          }),)
      );
      return Future.value(null);
    }

    if (_loading) {
      return Future.value(null);
    }

    setState(() {
      _loading = true;
    });

    return ClippingsAPI().getClippings(_take_pre_page, _offset).then((result) {
      setState(() {
        _loading = false;
        _hasMore = result.length != 0;
        _offset += _take_pre_page;
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

    return this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Color(0xfffafcff),
        child: RefreshIndicator(
          child: ListView.builder(
            controller: _listViewController,
            itemCount: this._clippingItems.length + 1,
            itemBuilder: (ctx, index) {
              if (index < _clippingItems.length) {
                return CardClipping(item: _clippingItems[index]);
              }
              return LoadingItem(visible: _loading && this._clippingItems.length > 0);
            },
          ),
          onRefresh: this._onRefresh),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
