import 'package:beumed/Class/Model/Enum_TypeDecoration.dart';
import 'package:beumed/View/Det_Event/Det_Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../Class/BUT000.dart';
import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeState.dart';

extension BoxSelectUser on Det_EventViewState {
  //Seleziona User
  Widget SelectUser(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: DropdownSearch<BUT000>(
          enabled: widget.state == TypeState.read ? false : true,
          items:
              master.array_user.where((element) => element.cf != '').toList(),
          itemAsString: (BUT000 element) => element.cf == ''
              ? ''
              : element.nome + ' ' + element.cognome + ' - ' + element.cf,
          popupProps: PopupProps.menu(
            showSearchBox: true,
          ),
          dropdownButtonProps:
              DropdownButtonProps(color: master.theme(size).primaryColor),
          dropdownDecoratorProps: DropDownDecoratorProps(
            //Bottone
            baseStyle: master
                .theme(size)
                .textTheme
                .bodyMedium, //Testo mostrato nel campo
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration:
                TypeDecoration.labolBord.value(context, 'Paziente'),
          ),
          onChanged: (value) {
            setState(() {
              userSelected = value!;
              //create_arrayHour(data_inizio);
            });
          },
          selectedItem: userSelected,
          validator: (valid) {
            if (valid is BUT000 && valid.cf == '')
              return 'Selezionare un Paziente!';
          }),
    );
  }
}
