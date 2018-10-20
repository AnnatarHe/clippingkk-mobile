import 'dart:ui';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:flutter/material.dart';

const _defaultBackgroundImage =
    'https://kindle.annatarhe.com/coffee-d3ec79a0efd30ac2704aa2f26e72cb28.jpg';

// Flutter 尚不支持命名路由, 所以没能加入到根路由上
class DetailPage extends StatelessWidget {
  static const platform = const MethodChannel('com.annatarhe.clippingkk/channel');
  final ClippingItem item;

  DetailPage({@required this.item}) {
    this._buildImage();
  }

  void _buildImage() async {
    final recorder = new PictureRecorder();
    final canvas = new Canvas(recorder,
        new Rect.fromPoints(new Offset(0.0, 0.0), new Offset(200.0, 200.0)));

    final stroke = new Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    canvas.drawRect(new Rect.fromLTWH(0.0, 0.0, 200.0, 200.0), stroke);

    final paint = new Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        new Offset(
          200.0,
          200.0,
        ),
        20.0,
        paint);

    final picture = recorder.endRecording();
    final img = picture.toImage(200, 200);

    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
    final bool result = await platform.invokeMethod("saveImage", { 'image': pngBytes.buffer.asUint8List() });

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(_defaultBackgroundImage),
                fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
            child: Center(
                child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Container(
                            margin: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Image.network(_defaultBackgroundImage),
                                Text(item.content),
                              ],
                            )))))),
      ),
    );
  }
}
