import 'package:ClippingKK/components/appbar-title.dart';
import 'package:flutter/material.dart';
import 'package:ClippingKK/model/appConfig.dart';
import './pages/home.dart';
import './pages/profile.dart';
import './pages/squre.dart';

class IndexPage extends StatefulWidget {
  @override
  IndexPageState createState() {
    return new IndexPageState();
  }
}

class IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  bool _hasToken = false;

  List<Widget> _tabs = [];

  IndexPageState() {
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

    if (_tabs.length == 0) {
    _tabs.addAll([
      HomePage(),
      SqurePage(),
      ProfilePage(),
    ]);
    }

    return _tabs[_currentIndex];
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
        title: AppBarTitle(tabIndex: this._currentIndex),
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