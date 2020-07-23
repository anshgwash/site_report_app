// flutter
import 'package:flutter/material.dart';
// sitereportapp
import 'package:sitereportapp/FormText.dart';
import 'package:sitereportapp/FormImages.dart';

class FormSelectorTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Form'),
              Tab(text: 'Images'),
            ],
          ),
          title: Text('Site Report App'),
          centerTitle: true,
          elevation: 0,
        ),
        body: TabBarView(
          children: <Widget>[
            FormText(),
            FormImages(),
          ],
        ),
      ),
    );
  }
}