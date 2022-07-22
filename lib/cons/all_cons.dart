import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllCons {
  static const String BASE_URL = 'https://botdodasi.uz/api/menudodasi/';
  static const String TOKEN = '61ab012f2319cc50908b068564718474';
}

void prt(String message) {
  if (kDebugMode) {
    print('MenuDodasi-> $message');
  }
}

void snackAction(context,message) {
  final SnackBar snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Закрыть',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void snack(context,message) {

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
