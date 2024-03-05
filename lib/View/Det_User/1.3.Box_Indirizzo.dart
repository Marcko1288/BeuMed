import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeDecoration.dart';
import '../../Class/Model/Enum_TypeState.dart';
import '../../Model/TextFieldCustom.dart';
import '0.Det_User.dart';

extension BoxIndirizzo on Det_UserViewState {
  Widget TextAddress(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: master.crossGrid(size),
        childAspectRatio: master.childGrid(size),
        children: [
          TextFieldCustom(
            text_labol: 'Indirizzo',
            text_default: indirizzo,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              indirizzo = value;
            },
          ),
          TextFieldCustom(
            text_labol: 'CAP',
            text_default: cap,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            limit_char: 5,
            onStringChanged: (String value) {
              cap = value;
            },
          ),
          TextFieldCustom(
            text_labol: 'Città',
            text_default: citta,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              citta = value;
            },
          ),
          TextFieldCustom(
            text_labol: 'Provincia',
            text_default: provincia,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            limit_char: 2,
            onStringChanged: (String value) {
              provincia = value;
            },
          ),
        ]
    );
  }
}
