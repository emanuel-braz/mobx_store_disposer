import 'package:example/pages/basic_example/stores/store_a.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

class ChildWidgetWithReaction extends StatefulWidget {
  @override
  _ChildWidgetWithReactionState createState() =>
      _ChildWidgetWithReactionState();
}

class _ChildWidgetWithReactionState
    extends StoreManager<ChildWidgetWithReaction> {
  StoreA storeA;

  @override
  void init(BuildContext context, StoreManager<ChildWidgetWithReaction> state) {
    /// Get Store from parent widget via DI
    storeA = StoreInject().get<StoreA>();

    /// Register reaction to child widget manage it
    this.addWidgetReaction(
        builder: (context) => reaction(
              (_) => storeA.errorMessage,
              (_) => print(
                  'CHILD WIDGET MANAGED - REACTION from ${this.runtimeType.toString()}: ${storeA.errorMessage}'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: <Widget>[
          Text('Error message from reaction managed by child widget:'),
          storeA.errorMessage == storeA.errorMessage1
              ? Text(
                  storeA.errorMessage1,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              : Text(storeA.errorMessage2,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold))
        ],
      );
    });
  }
}
