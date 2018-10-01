import 'package:flutter/material.dart';

class SqureState extends State<SqurePage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('暂未开放，敬请期待'));
  }
}

class SqurePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SqureState();
  }
}
