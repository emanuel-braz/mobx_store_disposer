import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/src/i_reaction_methods.dart';
import 'package:mobx_store_disposer/src/reaction_disposable.dart';
import 'package:mobx_store_disposer/src/store_inject.dart';
import 'package:mobx_store_disposer/src/store_manager.dart';
import 'package:mobx_store_disposer/src/util.dart';

/// Add all your reactions inside it
///
/// You can use `addWidgetReaction` or `addWidgetReactionList`
///
/// ### Example:
/// ```dart
///addWidgetReaction(builder: (context) =>
///  reaction(
///    (_) => store.errorMessage, 
///    (_) => showDialog(...)
///  )
///);
/// ```

mixin StoreDisposer <T extends StoreManager> implements IReactionMethods {

  static bool debugMode = false;
  
  String instanceName;
  List<dynamic> _businessReactionDisposer = List<dynamic>();

  @protected
  T state;
  
  @mustCallSuper
  void register<I>(BuildContext context, T state, {bool autoInject, String name}) {

    if (I == dynamic) throw 'Please inform the Store Type: register<[STORE_TYPE]>(context, state);';
    
    this.state = state;
    this.instanceName = name;
    autoInject ??= true;

    /// Register Store to be disposed (@override dispose method to consume that event)
    try {
      this.state.addStore(this);
    } catch (e) {
      throw FlutterError('You cannot register the same Store more than once');
    }

    /// Register store as singleton and it can be used through the entire app (DI)
    if (autoInject == true) StoreInject().register<I>(this as I, name: name);

  }

  /// Override it, if you wanna get an optional way to dispose things. 
  /// Generally we are talking about [StreamController]s and [ReactionDisposer]s that
  /// dont access UI objects, and do not participate of the auto dispose flow driven
  /// by [StoreManager] on registered Reactions. (reactions that is not registered via
  /// [this.addWidgetReaction] should be disposed in this dispose method)
  @mustCallSuper
  void dispose(){
    
    for (final urd in _businessReactionDisposer){
      if (urd is ReactionDisposer) {
        urd();
        trace('[${this.runtimeType.toString()}] BUSINESS REACTION DISPOSED: ${urd.reaction.name}');
      }
    }

    trace('[${this.runtimeType}] STORE DISPOSED');
  }

  /// Call this method to register all your business logic reaction to be disposed
  void addReactions(List<dynamic> list) => _businessReactionDisposer.addAll(list);

  String addWidgetReaction({@required ReactionDisposer Function(BuildContext) builder, String name, bool forceUpdate = false, StoreManager currentState}){
    if (currentState != null) return currentState.addWidgetReaction(builder: builder, name: name, forceUpdate: forceUpdate);
    return this.state.addWidgetReaction(builder: builder, name: name, forceUpdate: forceUpdate);
  }
  int addWidgetReactionList(List<ReactionDisposer Function(BuildContext)> builders, {StoreManager currentState}){
    if (currentState != null) return currentState.addWidgetReactionList(builders);
    return this.state.addWidgetReactionList(builders);
  }
  bool removeWidgetReaction({String name, ReactionDisposable reaction}){
    return this.state.removeWidgetReaction(name: name, reaction: reaction);
  }
  void removeAllWidgetReactions(){
    this.state.removeAllWidgetReactions();
  }
  String addWidgetAsynReaction(){
    return this.state.addWidgetAsynReaction();
  }

}