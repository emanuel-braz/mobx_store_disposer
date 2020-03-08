import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/src/util.dart';

class ReactionDisposable {
  final String name;
  final ReactionDisposer reaction;
  final String storeType;
  ReactionDisposable({@required this.reaction, this.name, this.storeType}): assert(reaction != null);
  
  void dispose() {
    try {
      reaction();
      trace('[${this.storeType}] UI REACTION DISPOSED: ($name:${reaction?.reaction?.name ?? "_"})');
    } catch (e) {}
  }
}