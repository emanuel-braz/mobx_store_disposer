import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';
part 'store_b.g.dart';

class StoreB = _StoreBBase with _$StoreB;

abstract class _StoreBBase with Store, StoreDisposer {

  @observable
  String info = "This text is provided through auto dependency injection";
}