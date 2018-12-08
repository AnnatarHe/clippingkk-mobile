import 'dart:typed_data';
import 'dart:ui';
import 'dart:core';
import 'dart:async';
import 'package:ClippingKK/components/clipping-content-text.dart';
import 'package:ClippingKK/model/doubanBookInfo.dart';
import 'package:ClippingKK/repository/douban.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ClippingKK/model/httpResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

const _defaultBackgroundImage =
    'https://kindle.annatarhe.com/coffee-d3ec79a0efd30ac2704aa2f26e72cb28.jpg';

const CANVAS_HEIGHT = 1920.0;
const CANVAS_WIDTH = 1080.0;

// Flutter 尚不支持命名路由, 所以没能加入到根路由上
class DetailPage extends StatefulWidget {
  final ClippingItem item;

  DetailPage({@required this.item});

  @override
  DetailPageState createState() {
    return new DetailPageState();
  }
}

class DetailPageState extends State<DetailPage> {

  static const platform =
  const MethodChannel('com.annatarhe.clippingkk/channel');

  static GlobalKey previewContainer = new GlobalKey();

  DoubanBookInfo _bookInfo;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  void _loadInfo() async {
    final info = await DoubanAPI().search(widget.item.title);
    setState(() {
      _bookInfo = info;
    });
  }

  void _saveScreenshot() async {
    RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();

    await platform.invokeMethod("saveImage", {'image': pngBytes.buffer.asUint8List()});
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImage =
        _bookInfo != null ? _bookInfo.image : _defaultBackgroundImage;
    final author = _bookInfo != null ? _bookInfo.author : '佚名';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.image), onPressed: this._saveScreenshot)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(backgroundImage), fit: BoxFit.cover)),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
            child: Center(
              child: RepaintBoundary(
                key: previewContainer,
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                  children: <Widget>[
                    ClippingContentText(content: this.widget.item.content),
                    Text(author)
    ],
                  ),
    )
    )
    ),
      ),
    ));
  }
}

class _ImageCanvas extends StatefulWidget {
  _ImageCanvas({
    Key key,
    this.bookInfo
  }) : super(key: key);

  DoubanBookInfo bookInfo;

  @override
  _ImageCanvasState createState() {
    return new _ImageCanvasState();
  }
}

class _ImageCanvasState extends State<_ImageCanvas> {
  static const platform =
      const MethodChannel('com.annatarhe.clippingkk/channel');

  static GlobalKey previewContainer = new GlobalKey();

  bool _loading = true;
  ByteData _img;

  @override
  void initState() {
    super.initState();
    this._buildImage();
  }

  Future<ui.Image> _loadImageAssets(String url) async {
    final _image = await http.readBytes(url);

    final bg = await ui.instantiateImageCodec(_image);
    final frame = await bg.getNextFrame();
    final img = frame.image;
    return img;
  }

  void _buildImage() async {
    final recorder = new PictureRecorder();
    final canvas = new Canvas(recorder,
        new Rect.fromPoints(new Offset(0.0, 0.0), new Offset(CANVAS_WIDTH, CANVAS_HEIGHT)));
    
    final paint = new Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final responses = await Future.wait([
      this._loadImageAssets(_defaultBackgroundImage),
    ]);

    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, CANVAS_WIDTH, CANVAS_HEIGHT), paint);

    final _paragraph = ParagraphBuilder(
        ParagraphStyle(textAlign: TextAlign.left, fontSize: 24.0)
      );
    _paragraph.addText('heelo jdklfjasdklfje');
    final p = _paragraph.build();
    p.layout(ParagraphConstraints(width: 100.0));
    // not working
    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, 200.0, 200.0), Paint()..color = Colors.amber);
    print(responses[0].width);
    print(responses[0].height);
    canvas.drawImage(responses[0], Offset.zero, Paint());
    canvas.drawParagraph(p, Offset(30.0, 30.0));

    final picture = recorder.endRecording();
    final pngBytes = await picture.toImage(CANVAS_WIDTH ~/ 1, CANVAS_HEIGHT ~/ 1).toByteData(format: ImageByteFormat.png);

    if (!this.mounted) {
      return;
    }

    setState(() {
      _img = pngBytes;
      _loading = false;
    });

    await platform.invokeMethod("saveImage", {'image': pngBytes.buffer.asUint8List()});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading && _img == null) {
      return Text('loading');
    }
    return Image.memory(new Uint8List.view(this._img.buffer));
  }
}
