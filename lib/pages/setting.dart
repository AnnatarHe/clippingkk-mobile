import 'package:flutter/material.dart';

const _settingList = [
  'about',
  'logout'
];

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/about");
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(_settingList[index]),
              ),
            )
          );
        },
        itemCount: _settingList.length,
      )
    );
  }

}
