import 'package:beumed/Class/Master.dart';
import 'package:beumed/Class/Model/Enum_TypeState.dart';
import 'package:beumed/Model/DataPickerNew.dart';
import 'package:beumed/Model/TextFieldCustom.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Class/Model/Enum_TypeDecoration.dart';
import '../Det_User/Det_User.dart';
import 'package:beumed/Class/Model/Enum_StatoCivile.dart';

extension BlockAnagrafico on Det_UserViewState {
  Widget TextFiscalDate(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: master.crossGrid(size),
        childAspectRatio: master.childGrid(size),
        children: [
          TextFieldCustom(
            text_labol: "Nome",
            text_default: nome,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              nome = value;
            },
            listValidator: [
              TypeValidator.required,
            ],
          ),
          TextFieldCustom(
              text_labol: 'Cognome',
              text_default: cognome,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                cognome = value;
              },
              listValidator: [
                TypeValidator.required,
              ]),
          TextFieldCustom(
              text_labol: 'Codice Fiscale',
              text_default: cf,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                cf = value;
              },
              listValidator: [TypeValidator.required, TypeValidator.cf]),
          TextFieldCustom(
              text_labol: 'Partita Iva',
              text_default: piva,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                piva = value;
              },
              listValidator: [TypeValidator.piva]),
          DatePickerNew(
            date: birthday,
            text_labol: 'Data di Nascita',
            enabled: widget.state == TypeState.read ? false : true,
            onDateChanged: (DateTime value) {
              setState(() {
                birthday = value;
              });
            },
          ),
          TextFieldCustom(
            text_labol: 'Luogo di Nascita',
            text_default: local_birthday,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              local_birthday = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownSearch<SelectionStatoCivile>(
              enabled: widget.state != TypeState.read,
              items: SelectionStatoCivile.arrayElement(),
              itemAsString: (SelectionStatoCivile element) => element.value,
              dropdownButtonProps: DropdownButtonProps(
                color: master.theme(size).primaryColor,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: TypeDecoration.labolBord.value(context, 'Stato Civile'),
              ),
              onChanged: (value) {
                setState(() {
                  stato_civile = value!;
                });
              },
              selectedItem: stato_civile,
            ),
          ),
        ]
    );
  }
}


