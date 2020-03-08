import 'package:example/utils/util.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

part 'store_a.g.dart';

class StoreA = _StoreABase with _$StoreA;

abstract class _StoreABase with Store, StoreDisposer {

  String errorMessage1 = 'Error Message 1';
  String errorMessage2 = 'Error Message 2';

  @observable
  String businessRandomText = 'INITIAL_TEXT';
  
  @observable
  String errorMessage = 'Error Message 1';

  _StoreABase(){
    this.addReactions([
      reaction(
        (_) => this.errorMessage,
        (_) => this.businessRandomText = getRandomIdentifier(),
        name: 'business_reaction'
      )
    ]);
  }

  @action
  void setError(){
    errorMessage = errorMessage == errorMessage1 ? errorMessage2 : errorMessage1;
  }
}
