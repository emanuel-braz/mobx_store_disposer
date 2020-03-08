
import 'dart:math';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message, [String title = 'Message:']){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[            
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}

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