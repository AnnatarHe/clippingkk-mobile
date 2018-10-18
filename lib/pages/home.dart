import 'package:ClippingKK/components/card-clipping.dart';
import 'package:ClippingKK/repository/clippings.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/model/httpResponse.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  List<ClippingItem> _clippingItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() {
    ClippingsAPI().getClippings(20, 0)
      .then((result) {
        setState(() {
          _clippingItems.addAll(result);
        });
      });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: this._clippingItems.length,
          itemBuilder: (ctx, index) {
            return CardClipping(item: _clippingItems[index]);
          },
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => {},
        tooltip: 'none',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
