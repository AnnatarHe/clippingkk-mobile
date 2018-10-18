import 'package:ClippingKK/model/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './pages/home.dart';
import './pages/profile.dart';
import './pages/squre.dart';
import './pages/auth.dart';

void main() async {
  final jwt = await FlutterSecureStorage().read(key: 'jwt');
  final uid = await FlutterSecureStorage().read(key: 'uid');
  AppConfig.jwtToken = jwt;
  AppConfig.uid = uid != null ? int.parse(uid) : -1;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClippingKK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _IndexPage(),
        '/auth': (context) => AuthPage()
      },
    );
  }
}

class _IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() {
    return new _IndexPageState();
  }
}

class _IndexPageState extends State<_IndexPage> {
  int _currentIndex = 0;
  bool _hasToken = false;

  _IndexPageState() {
    if (AppConfig.jwtToken != "") {
      _hasToken = true;
    }
  }

  @override
  initState() {
    super.initState();

    if (!this._hasToken) {
      Future.delayed(const Duration(microseconds: 10), () { _checkAuth(); });
    }
  }

  void _checkAuth() async {
    final result = await Navigator.pushNamed(context, '/auth');
    if (result != "") {
      _checkAuth();
    }

    setState(() {
      _hasToken = true;
    });
  }

  Widget _getBody() {
    if (!_hasToken) {
      return Text('placeholder');
    }

    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return SqurePage();
      case 2:
        return ProfilePage();
      default:
        return AuthPage();
    }
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            title: Text('Square'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.usb),
            title: Text('My'),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _changeTab,
      ),
      body: this._getBody(),
    );
  }
}
