import 'package:beumed/View/Det_User/Det_User.dart';
import 'package:beumed/View/Det_User/FuctionDet_User.dart';
import 'package:flutter/material.dart';

import '../../Class/Model/Enum_TypeState.dart';

extension WidgetDetUser on Det_UserViewState {
  Widget Title_AppBar(BuildContext context) {
    switch (widget.state) {
      case TypeState.read:
        return Text("Paziente");
      case TypeState.insert:
        return Text("Nuovo Paziente");
      case TypeState.modify:
        return Text("Modifica Paziente");
    }
  }

  Widget action_button(BuildContext contextT) {
    return FloatingActionButton(
      onPressed: () {
        actionElement();
      },
      tooltip: Title_Button(),
      child: widget.state == TypeState.read
          ? Icon(Icons.mode_edit_outline_outlined)
          : Icon(Icons.save_as_outlined),
    );
  }
}
