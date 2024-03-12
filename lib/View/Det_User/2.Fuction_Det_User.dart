import 'package:beumed/Class/BUT000.dart';
import 'package:beumed/View/Det_User/0.Det_User.dart';
import 'package:beumed/View/Det_User/3.Fire_Det_User.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_Profile.dart';
import '../../Class/Model/Enum_StatoCivile.dart';
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
    var master = Provider.of<Master>(context, listen: false);
    setState(() {
      var state = widget.state == TypeState.insert ? true : false;
      var user = widget.user ?? BUT000.standard();
      nome = state ? "" : user.nome;
      cognome = state ? "" : user.cognome;
      cf = state ? "" : user.cf;
      piva = state ? "" : user.piva;
      birthday = state ? DateTime.now() : user.birthday;
      local_birthday = state ? "" : user.local_birthday;
      indirizzo = state ? "" : user.indirizzo;
      citta = state ? "" : user.citta;
      cap = state ? "" : user.cap.toString();
      provincia = state ? "" : user.provincia;
      mail = state ? "" : user.mail;
      phone = state ? "" : user.phone.toString();
      mobile_phone = state ? "" : user.mobile_phone.toString();
      stato_civile = state ? SelectionStatoCivile.S1 : user.stato_civile;
      open_boxanamnesi = state ? true : false;
      anamnesi = state ? master.array_anamnesi : user.array_anamnesi;
      other = state ? "" : user.array_anamnesi.firstWhere((elem) => elem.nome == 'Altro',
          orElse: () => Anamnesi.standard()).other;
      note = state ? [] : user.array_note;
      profilo = state ? SelectionProfile.paziente : user.profilo;

      note.sort((a,b) =>(b.data.compareTo(a.data)));

    });
  }

  Future<void> actionElement() async {
    var master = Provider.of<Master>(context, listen: false);

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