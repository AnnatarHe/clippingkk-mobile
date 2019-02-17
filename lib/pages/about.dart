import 'package:ClippingKK/components/KKplaceholder.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: KKPlaceholder(),
    );
  }
}
