import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/View/Det_User/Det_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeDecoration.dart';
import '../../Class/Model/Enum_TypeState.dart';
import '../../Library/Enum_TypeFormatDate.dart';

extension BoxNote on Det_UserViewState {
  Widget TextNote(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    bool open_note = false;
    int length_note = 10;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InputDecorator(
        decoration: TypeDecoration.labolBord.value(context, "Note"),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: widget.state == TypeState.read ? null : () {
                  setState(() {
                    print('new_note: ${new_note}');
                    if (new_note == false) {
                      new_note = true;
                      note[DateTime.now()] = '';
                      print('new_note: ${new_note}');
                    }
                  });
                },
                icon: Icon(Icons.add_circle_outline),
              ),
            ),
            Column(
              children: note.entries.map((element) {
                String title = element.key.changeDateToString(type: TypeFormatDate.DD_MM_AAAA_HH_MM);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: element.value,
                          enabled: widget.state == TypeState.read ? false : true,
                          maxLines: length_note,
                          decoration: InputDecoration(
                            labelText: title,
                            focusedBorder: defaultBorder(master.theme(size).primaryColor),
                            enabledBorder: defaultBorder(master.theme(size).primaryColor),
                            disabledBorder: defaultBorder(master.theme(size).primaryColor),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              note[element.key] = value;
                            });
                          },
                        ),
                      ),
                      if (widget.state != TypeState.insert)
                        IconButton(
                          onPressed: widget.state == TypeState.read ? null : () {
                            setState(() {
                              open_note = !open_note;
                              length_note = open_note ? 10 : 1;
                            });
                          },
                          icon: open_note ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}