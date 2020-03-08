import 'package:example/pages/list_example/stores/list_item_store.dart';
import 'package:example/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

class ListItemButton extends StatelessWidget {

  final String storeName;

  const ListItemButton(this.storeName);

  Widget build(BuildContext context) {

    ListItemStore store = StoreInject().get(name: storeName);

    return ButtonTheme(
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8),
      textTheme: ButtonTextTheme.primary,
      child: RaisedButton(
        child: Text('CHANGE currName PROPERTY (${this.storeName})', textAlign: TextAlign.center,),
        onPressed: (){
          store.setCurrName(getRandomIdentifier());
        },
      ),
    );
  }
}