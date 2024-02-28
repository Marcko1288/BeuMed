import 'package:beumed/View/Det_User/Det_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeDecoration.dart';
import '../../Class/Model/Enum_TypeState.dart';
import '../../Model/RadioButton.dart';

extension BoxAnamnesi on Det_UserViewState {

  Widget TextAnamnesia(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InputDecorator(
        decoration: TypeDecoration.labolBord.value(context, "Anamnesi"),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      open_boxanamnesi = !open_boxanamnesi;
                    });
                  },
                  icon: open_boxanamnesi ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.keyboard_arrow_up),
                  ) : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ],
            ),
            if (open_boxanamnesi)
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: master.childGrid(size),
                children: [
                  Container(), // Assicurati che il contenuto del GridView.count abbia un'implementazione corretta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('SI'), Text('NO')],
                  ),
                ],
              ),
            if (open_boxanamnesi)
              Column(
                children: anamnesi.entries.map((element) {
                  return RadioButtonCustom(
                    text: element.key,
                    select: element.value,
                    enabled: widget.state == TypeState.read ? false : true,
                    onChanged: (value) {
                      setState(() {
                        anamnesi[element.key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            if (open_boxanamnesi)
              TextFormField(
                initialValue: other,
                enabled: widget.state == TypeState.read ? false : true,
                maxLines: 10,
                decoration: TypeDecoration.labolBord.value(context, 'Altro'),
                onChanged: (String value) {
                  setState(() {
                    other = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}