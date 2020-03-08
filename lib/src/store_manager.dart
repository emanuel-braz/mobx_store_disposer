import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/src/i_reaction_methods.dart';
import 'package:mobx_store_disposer/src/reaction_disposable.dart';
import 'package:mobx_store_disposer/src/store_disposer.dart';
import 'package:mobx_store_disposer/src/store_inject.dart';
import 'package:mobx_store_disposer/src/util.dart';

class StoreManager<T extends StatefulWidget> extends State<T> implements IReactionMethods {
  
  List<ReactionDisposable> _reactionList = <ReactionDisposable>[];
  List<StoreDisposer> _storeList = <StoreDisposer>[];
  List<ReactionDisposable> get reactions => _reactionList;

  @override
  void initState() {
    super.initState();
    init(context, this);
  }

  String addWidgetReaction({@required ReactionDisposer Function(BuildContext) builder, String name, bool forceUpdate = false, State currentState}){
    if (builder == null) throw FlutterError('Error: builder is a required argument!');
    bool reactionExists = !_reactionList.every((reactionDisposable) => reactionDisposable.name != name);

    if (reactionExists){
      if (forceUpdate == false) return null;
      else {
        this.removeWidgetReaction(name: name);
      }
    }
    name ??= getRandomIdentifier();
    ReactionDisposer rd = builder(this.context);

    _reactionList.add(ReactionDisposable(
      reaction: rd, 
      name: name,
      storeType: this.runtimeType.toString()
      )
    );
    return name;
  }

  void addStore(StoreDisposer storeDisposer){
    bool storeExists = existsStore(storeDisposer);
    if (storeExists == true) throw FlutterError('There is a Store instance registered yet');
    this._storeList.add(storeDisposer);
  }

  bool existsStore(StoreDisposer storeDisposer){
    return this._storeList.contains(storeDisposer);
  }

  /// TODO to be implemented
  String addWidgetAsynReaction() => null;

  int addWidgetReactionList(List<ReactionDisposer Function(BuildContext)> builders, {State currentState}){
    builders.forEach((builder) {
      this.addWidgetReaction(builder: builder);
    });
    return _reactionList.length;
  }

  bool removeWidgetReaction({String name, ReactionDisposable reaction}){
    assert(name == null || reaction == null,'Cannot provide both a identifier and a reaction\n');

    ReactionDisposable rd;
    if (name != null) rd = _reactionList.firstWhere((element) => element.name == name);
    else {
      int index = _reactionList.indexOf(reaction);
      if (index > -1) rd = _reactionList.elementAt(index);
    } 

    if (rd != null){
      _reactionList.remove(rd);
      rd.dispose();
      return true;
    }
    return false;
  }

  void removeAllWidgetReactions(){
    _reactionList.forEach((element) {
      _reactionList.remove(element);
      element.dispose();
    });
  }

  @override
  void dispose() {
    disposeReactions();
    disposeStores();
    super.dispose();
  }
  void disposeReactions() => _reactionList.forEach((reactionDisposable) => reactionDisposable.dispose());
  void disposeStores() => _storeList.forEach((store) => StoreInject().unregister(store, name: store.instanceName));
  
  void init(BuildContext context, StoreManager<T> state){
    throw FlutterError('Please override initStoreAndReactions(context, state) method in ${this.runtimeType.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    throw FlutterError('Please override build(context) method in ${this.runtimeType.toString()}');
  }

  String getUniqueName({String storeName = ""}) =>
    '$storeName\_${this.runtimeType.toString()}_${this.hashCode.toString()}_${getRandomIdentifier()}_${DateTime.now().microsecondsSinceEpoch.toString()}';
}