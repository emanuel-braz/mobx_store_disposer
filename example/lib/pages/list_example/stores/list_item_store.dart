import 'package:example/pages/list_example/list_item_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

part 'list_item_store.g.dart';

class ListItemStore = _ListItemStoreBase with _$ListItemStore;

abstract class _ListItemStoreBase with Store, StoreDisposer<ListItemWidgetState> {

  @observable
  String currName = "currName";

  @action
  void setCurrName(String newCurrName) => currName = newCurrName;
  
}