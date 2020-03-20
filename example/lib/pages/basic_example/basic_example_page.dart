import 'package:example/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:example/pages/basic_example/child_widget_di.dart';
import 'package:example/pages/basic_example/child_widget_with_reaction.dart';
import 'package:example/pages/basic_example/stores/store_a.dart';
import 'package:example/pages/basic_example/stores/store_b.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

class BasicExamplePage extends StatefulWidget {
  @override
  _BasicExamplePageState createState() => _BasicExamplePageState();
}

class _BasicExamplePageState extends StoreManager<BasicExamplePage> {
  
  /// Store reference
  StoreA storeA;

  /// REQUIRED: Init Stores and Reactions to State [StoreManager]
  @override
  void registerStore(BuildContext context, State state) {
    
    // Init Store 
    storeA = StoreA()..register<StoreA>(context, state);

    // Added some reactions to StoreManager takes care
    this..addWidgetReaction(
      builder: (context) => autorun(
        (_) {
          showAlert(context, 'Autorun Reaction Executed');
          print('PARENT WIDGET MANAGED - AUTORUN from StoreA${this.runtimeType.toString()}');
        },
        delay: 1 // IMPORTANT: delay needed, it's schedules autorun to next frame
        ),
    )
    ..addWidgetReaction(
      builder: (context) => reaction(
        (_) => storeA.errorMessage,
        (_) => print('PARENT WIDGET MANAGED - REACTION from StoreA${this.runtimeType.toString()}: ${storeA.errorMessage}')
      ),
    )
    ..addWidgetReaction(
        builder: (_) => when(
          (_) => storeA.errorMessage == storeA.errorMessage2,
          () => print('PARENT WIDGET MANAGED - WHEN from StoreA${this.runtimeType.toString()}: ${storeA.errorMessage}')));
  

    // Another Store to be used in children Widgets via DI
    // As the store was initiated inside this state, the store got a reference of State
    // so it can addWidgetReation directly in StoreB
    StoreB()..register<StoreB>(context, state)
    ..addWidgetReaction(
      name: 'StoreB_NAMED_REACTION',
      builder: (context) => autorun(
        (_) => print('AUTORUN DISPATCHED from StoreB${this.runtimeType.toString()}')),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ChildWidgetWithReaction(),
          SizedBox(height: 16),
          ChildWidgetDI(),
          SizedBox(height: 16),
          ButtonTheme(
            padding: EdgeInsets.symmetric(vertical: 8),
            minWidth: double.infinity,
            textTheme: ButtonTextTheme.primary,
            child: RaisedButton(
              onPressed: () {
                storeA.setError();
              },
              child: Text('PRINT MESSAGE ERROR (reactions from parent and children widget)', textAlign: TextAlign.center),
            ),
          ),
        ]),
      ),
    );
  }
}
