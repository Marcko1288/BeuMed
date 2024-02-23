import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Master.dart';

enum TypeDecoration { focusBord, labolBord }

extension ExtTypeDecoration on TypeDecoration {
  dynamic value(BuildContext context, String value) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    switch (this) {
      case TypeDecoration.focusBord:
        return decorationFocusBord(context, value);
      case TypeDecoration.labolBord:
        return decorationLabolBord(context, value);
    }
  }
}

OutlineInputBorder defaultBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: color),
  );
}

InputDecoration decorationLabolBord(BuildContext context, String text_labol){
  var master = Provider.of<Master>(context, listen: false);
  var size = MediaQuery.of(context).size;

  return InputDecoration(
    labelText: text_labol,
    focusedBorder: defaultBorder(master.theme(size).primaryColor),
    enabledBorder: defaultBorder(master.theme(size).primaryColor),
    disabledBorder: defaultBorder(master.theme(size).primaryColor),
    focusedErrorBorder: defaultBorder(master.theme(size).primaryColor),
    errorBorder: defaultBorder(master.theme(size).primaryColor),
  );
}

InputDecoration decorationFocusBord(BuildContext context, String text_labol){
  var master = Provider.of<Master>(context, listen: false);
  var size = MediaQuery.of(context).size;

  return InputDecoration(
    hintText: text_labol,
    focusedBorder: defaultBorder(master.theme(size).primaryColor),
    enabledBorder: defaultBorder(master.theme(size).primaryColor),
    disabledBorder: defaultBorder(master.theme(size).primaryColor),
    focusedErrorBorder: defaultBorder(master.theme(size).primaryColor),
    errorBorder: defaultBorder(master.theme(size).primaryColor),
  );
}
