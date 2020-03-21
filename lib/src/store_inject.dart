import 'package:get_it/get_it.dart';
import 'package:mobx_store_disposer/src/store_disposer.dart';
import 'package:mobx_store_disposer/src/util.dart';

class StoreInject {
  
  StoreInject.private();
  static StoreInject get _instance => StoreInject.private();
  factory StoreInject() => _instance;

  void register<T>(T instance, {String name}) {

    bool exists = false;
    if (name != null) try {exists = GetIt.I.get(instanceName: name) != null;} catch(e){} 
    else try {exists = GetIt.I.get<T>() != null;} catch(e){}

    if (exists == true){
      String error = 'Error: Already exists an instance of [$T] - Can\'t register a new instance with same type already registered.\n'
      ' -> If you need multiple instances of the same type, you can try to name them with a unique instanceName.\n'
      'Eg. super.register<T>(context, state, name: "YOUR_UNIQUE_STORE_IDENTIFIER");\n';
      print('\x1B[31m[ERROR] ==>> \x1B[0m $error');
      return; 
    }

    if (name != null)
      try{GetIt.I.registerSingleton(instance, instanceName: name);} catch(e){ print('Error: Fail to register DI. You should override register<I>(...) method of ${(instance as dynamic).runtimeType} class, in order to avoid unexpected behavior');}
    else
      try{GetIt.I.registerSingleton<T>(instance);} catch(e){ print('Error: $e\n-> You can\'t register a new instance with same type already registered.\n-> Please inform argument [instanceName]');}
  }

  T get<T>({String name}) {
    if (name != null)
      try {return GetIt.I.get(instanceName: name);} catch (e) {return null;}
    else
      try {return GetIt.I.get<T>();} catch (e) {return null;}
  }

  void unregister<T>(T instance, {String name}) {
    if (name != null)
      try {
        trace('[${this.runtimeType.toString()}] DISPOSE BY NAME: $name');
        GetIt.I.unregister(instance: instance, instanceName: name, disposingFunction: (i) => i.dispose());  
      } catch (e) {}
    else
      try {
        GetIt.I.unregister<StoreDisposer>(instance: instance, disposingFunction: (i) => i.dispose());  
      } catch (e) {}
  }
}
