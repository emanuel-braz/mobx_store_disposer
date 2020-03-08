import 'package:example/pages/list_example/list_item_widget.dart';
import 'package:flutter/material.dart';

class ListStoreExamplePage extends StatefulWidget {
  @override
  ListStoreExamplePageState createState() => ListStoreExamplePageState();
}

class ListStoreExamplePageState extends State<ListStoreExamplePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListItemWidget('StoreID00$index');
        })),
    );
  }
}
