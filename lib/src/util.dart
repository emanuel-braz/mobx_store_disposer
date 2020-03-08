import 'dart:core';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:mobx_store_disposer/mobx_store_disposer.dart';

String getRandomIdentifier([int strlen = 8]) {
 var rand = new Random();
   var codeUnits = new List.generate(
      strlen, 
      (index){
         return rand.nextInt(33)+89;
      }
   );
   return new String.fromCharCodes(codeUnits);
}

void trace(Object value){
  if (!kReleaseMode && StoreDisposer.debugMode == true) print('${DateTime.now().toUtc()}: $value');
}