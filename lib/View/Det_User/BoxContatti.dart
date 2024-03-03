import 'package:beumed/View/Det_User/Det_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeDecoration.dart';
import '../../Class/Model/Enum_TypeState.dart';
import '../../Model/TextFieldCustom.dart';

extension BoxContatti on Det_UserViewState {
  Widget TextContact(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: master.crossGrid(size),
      childAspectRatio: master.childGrid(size),
      children: [
        TextFieldCustom(
            text_labol: 'Mail',
            text_default: mail,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              mail = value;
            },
            listValidator: [TypeValidator.required, TypeValidator.email]),
        TextFieldCustom(
            text_labol: 'Telefono Fisso',
            text_default: phone,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              phone = value;
            },
            listValidator: [TypeValidator.number]),
        TextFieldCustom(
            text_labol: 'Cellulare',
            text_default: mobile_phone,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              mobile_phone = value;
            },
            listValidator: [TypeValidator.required, TypeValidator.number]),
      ],
    );
  }
}