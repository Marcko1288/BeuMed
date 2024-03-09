import 'package:beumed/View/Det_Event/0.Det_Event.dart';
import 'package:beumed/View/Det_Event/2.Function_Det_Event.dart';
import 'package:flutter/material.dart';

import '../../Class/Model/Enum_TypeState.dart';

extension WidgetDetEvent on Det_EventViewState {
  Widget Title_AppBar(BuildContext context) {
    switch (widget.state) {
      case TypeState.read:
        return Text("Appuntamento");
      case TypeState.insert:
        return Text("Nuovo Appuntamento");
      case TypeState.modify:
        return Text("Modifica Appuntamento");
    }
  }

  Widget action_button(BuildContext context) {
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
