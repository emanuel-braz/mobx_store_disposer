import 'package:example/pages/basic_example/basic_example_page.dart';
import 'package:example/pages/list_example/list_example_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: ButtonTheme(
            minWidth: double.infinity,
            textTheme: ButtonTextTheme.primary,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => BasicExamplePage()),
                  );
                },
                child: Text('Single Type Instance'),
              ),
              Text(
                'A single or multiple stores with differents types, working in cascade managment',
                style: TextStyle(fontSize: 11),
              ),
              SizedBox(height: 16),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ListStoreExamplePage()));
                },
                child: Text('Multiple Store - Same type Instance (named store)'),
              ),
              Text(
                'Multiple instances of same type stores, but differents IDs (Use carefully!)',
                style: TextStyle(fontSize: 11),
              ),
            ])),
      ),
    );
  }
}