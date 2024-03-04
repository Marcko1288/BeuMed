import 'package:beumed/Class/Model/Enum_TypeDecoration.dart';
import 'package:beumed/Model/TextFieldCustom.dart';
import 'package:beumed/View/Det_Event/Det_Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeState.dart';

extension BoxNote on Det_EventViewState {
  //Inserimento Note
  Widget InsertNote(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Expanded(
      child: TextFormField(
        initialValue: note,
        enabled: widget.state == TypeState.read ? false : true,
        maxLines: 10,
        decoration: TypeDecoration.labolBord.value(context, 'Note'),
        // InputDecoration(
        //   labelText: "Note",
        //   focusedBorder: defaultBorder(master.theme(size).primaryColor),
        //   enabledBorder: defaultBorder(master.theme(size).primaryColor),
        //   disabledBorder: defaultBorder(master.theme(size).primaryColor),
        // ),
        onChanged: (String value) {
          setState(() {
            note = value;
          });
        },
      ),
    );
  }
}
