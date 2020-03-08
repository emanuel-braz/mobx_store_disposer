import 'package:example/pages/list_example/list_item_button.dart';
import 'package:example/pages/list_example/stores/list_item_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';


class ListItemWidget extends StatefulWidget {
  final String instanceName;
  const ListItemWidget(this.instanceName);

  @override
  ListItemWidgetState createState() => ListItemWidgetState();
}

class ListItemWidgetState extends StoreManager<ListItemWidget> {
  
  ListItemStore store;

  @override
  void init(BuildContext context, StoreManager<ListItemWidget> state) {
    store = ListItemStore()..init<ListItemStore>(context, state, name: widget.instanceName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(children: [
          Observer(builder: (_) {
            return Text(store.currName);
          }),
          ListItemButton(widget.instanceName)
        ]));
  }
}
