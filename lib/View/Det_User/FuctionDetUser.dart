import 'package:beumed/View/Det_User/Det_User.dart';
import 'package:beumed/View/Det_User/FireDet_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_Profile.dart';
import '../../Class/Model/Enum_TypeState.dart';

extension FuncDetUser on Det_UserViewState {
  String Title_Button() {
    switch (widget.state) {
      case TypeState.read:
        return 'Modifica Paziente';
      case TypeState.insert:
        return 'Salva Paziente';
      case TypeState.modify:
        return 'Salva Paziente';
    }
  }

  void refreshDate() {
    setState(() {
      if (widget.state == TypeState.insert) {
        mail = '';
        cf = '';
        nome = '';
        cognome = '';
        profilo = SelectionProfile.paziente;
        indirizzo = '';
        citta = '';
        cap = '';
        provincia = '';
      } else {
        mail = widget.user!.mail;
        cf = widget.user!.cf;
        nome = widget.user!.nome;
        cognome = widget.user!.cognome;
        profilo = widget.user!.profilo;
        indirizzo = widget.user!.indirizzo;
        citta = widget.user!.citta;
        cap = widget.user!.cap.toString();
        provincia = widget.user!.provincia;
      }
    });
  }

  Future<void> actionElement() async {
    var master = Provider.of<Master>(context, listen: false);

    print('widget.state: ${widget.state}');
    if (formKey.currentState!.validate()) {
      if (widget.state == TypeState.read) {
        setState(() {
          widget.state = TypeState.modify;
        });
      } else {
        if (widget.state == TypeState.insert) {
          if (widget.user == null) {
            await insertElement();
          } else {
            await modifyElement();
          }
        }
        if (widget.state == TypeState.modify) {
          await modifyElement();
        }
      }
    }
  }
}