import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/src/reaction_disposable.dart';
import 'package:mobx_store_disposer/src/store_manager.dart';

abstract class IReactionMethods {

  /// [forceUpdate] if exists previous, replace reaction instance
  /// [currentState] register reaction to the current widget [StoreManager]
  String addWidgetReaction({@required ReactionDisposer Function(BuildContext) builder, String name, bool forceUpdate = false, StoreManager currentState});
  int addWidgetReactionList(List<ReactionDisposer Function(BuildContext)> builders, {StoreManager currentState});
  bool removeWidgetReaction({String name, ReactionDisposable reaction});
  void removeAllWidgetReactions();
  String addWidgetAsynReaction();
}

