import 'package:example/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Enable lib debug print
    StoreDisposer.debugMode = true;

    return MaterialApp(
      title: 'MobX Store Disposer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MobX Store Disposer Demo'),
    );
  }
}