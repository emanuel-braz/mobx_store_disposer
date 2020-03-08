## mobx_store_disposer (flutter package)

An auto disposable MobX reactions and stores approach, with auto dependency injection. (Reactions can be managed by different State Widgets in widget tree)

### Example

```yaml
# add dependency to pubspec.yaml

mobx_store_disposer:
    git: https://github.com/emanuel-braz/mobx_store_disposer.git
```

```dart
// Enable lib debug print
StoreDisposer.debugMode = true;
```

```dart
// store_a.dart

import 'package:mobx_store_disposer/mobx_store_disposer.dart';

part 'store_a.g.dart';

class StoreA = _StoreABase with _$StoreA;

abstract class _StoreABase with Store, StoreDisposer {
  @observable
  String message = 'initial message';
}
```

```dart
// example_page.dart

class ExamplePage extends StatefulWidget {
  @override
  ExamplePageState createState() => ExamplePageState();
}

class ExamplePageState extends StoreManager<ExamplePage> {
  
  /// Store reference
  StoreA storeA;

  /// OVERRIDE REQUIRED: Init Stores and Reactions
  @override
  void init(BuildContext context, State state) {
    
    // Init Store 
    storeA = StoreA()..init<StoreA>(context, state);

    // Add reaction to StoreManager
    this.addWidgetReaction(
      builder: (context) => autorun(
        (_) {
          print(storeA.message);
        },
      )
  }

  @override
  Widget build(BuildContext context) {
    return ChildWidgetDI();
  }
}
```

```dart
// child_widget_di.dart

class ChildWidgetDI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    var storeA = StoreInject().get<StoreA>();

    return Chip(
      label: Text(
        storeA.message
      ),
    );
  }
}
```
