import 'package:example/pages/basic_example/stores/store_b.dart';
import 'package:flutter/material.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

class ChildWidgetDI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var storeB = StoreInject().get<StoreB>();

    return Chip(
      label: Text(
        storeB.info,
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }
}
