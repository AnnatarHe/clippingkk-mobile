import 'package:ClippingKK/components/card-clipping.dart';
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

class _MyHomePageState extends State<HomePage> {
  List<ClippingItem> _clippingItems = [];
  ScrollController _listViewController = ScrollController();

  bool _loading = false;
  bool _hasMore = true;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _listViewController.addListener(() {
      if (_listViewController.position.pixels ==
          _listViewController.position.maxScrollExtent) {
        this.loadData();
      }
    });
    loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _listViewController.dispose();
  }

  void loadData() {
    if (_loading || !_hasMore) {
      return;
    }

    setState(() {
      _loading = true;
    });

    ClippingsAPI().getClippings(_take_pre_page, _offset).then((result) {
      setState(() {
        _loading = false;
        _hasMore = result.length != 0;
        _offset += _take_pre_page;
        _clippingItems.addAll(result);
      });
    }).catchError(() {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: ListView.builder(
          controller: _listViewController,
          itemCount: this._clippingItems.length,
          itemBuilder: (ctx, index) {
            return CardClipping(item: _clippingItems[index]);
          },
        ),
      ),
    );
  }
}
