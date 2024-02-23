import 'package:beumed/Library/Extension_String.dart';
import 'package:beumed/View/Det_User/Det_User.dart';
import 'package:beumed/View/Det_User/FuctionDetUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/BUT000.dart';
import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeState.dart';
import '../../Library/FireAuth.dart';
import '../../Library/FireStore.dart';

extension FireDetUser on Det_UserViewState {
  Future<void> insertElement() async {
    var master = Provider.of<Master>(context, listen: false);
    bool insert = true;

    var result_data = master.array_user.where((e) => e.cf == cf);
    if (result_data.isNotEmpty) {
      insert == false;
      setState(() {
        master.gestion_Message('Utente già registrato!');
        return;
      });
    }

    if (insert == true) {
      var user = BUT000(
          mail: mail,
          cf: cf,
          nome: nome,
          cognome: cognome,
          piva: piva,
          indirizzo: indirizzo,
          citta: citta,
          cap: cap.changeStringToInt(),
          provincia: provincia,
          uidBUT000: master.user.uid);

      try {
        var dirDB = FireStore()
            .dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
        var element_map = user.toDB();
        await FireStore().insertFirestore(patch: dirDB, map: element_map);
        print('Caricamento OK');
        widget.user = user;
        master.array_user.add(user);

        setState(() {
          master.gestion_Message('Dati caricati correttamente');
          widget.state = TypeState.read;
          refreshDate();
          return;
        });
        return;
      } on FirebaseException catch (error) {
        print('${error.toString()}');
        setState(() {
          master.gestion_Message(
              'Errore caricamento nel DB, ${error.toString()}');
          return;
        });
        return;
      }
    }
  }

  Future<void> modifyElement() async {
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_user
        .indexWhere((element) => element.uid == widget.user!.uid);
    master.array_user[index].mail = mail;
    master.array_user[index].cf = cf;
    master.array_user[index].nome = nome;
    master.array_user[index].cognome = cognome;
    master.array_user[index].piva = piva;
    master.array_user[index].indirizzo = indirizzo;
    master.array_user[index].citta = citta;
    master.array_user[index].cap = cap.changeStringToInt();
    master.array_user[index].provincia = provincia;

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
      var element_map = master.array_user[index].toDB();
      await FireStore().modifyFireStore(patch: dirDB, map: element_map);
      print('Modifica OK');

      setState(() {
        master.gestion_Message('Dati modificati correttamente');
        widget.state = TypeState.read;
        refreshDate();
        return;
      });
      return;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master
            .gestion_Message('Errore caricamento nel DB, ${error.toString()}');
        return;
      });
      return;
    }
  }

  Future<void> deleteElement() async {
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_user
        .indexWhere((element) => element.uid == widget.user!.uid);

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
      var element_map = master.array_user[index].toDB();
      await FireStore().cancelFireStore(patch: dirDB, map: element_map);
      print('Cancellazione OK');

      master.array_user.removeAt(index);

      setState(() {
        master.gestion_Message('Dati cancellati correttamente');
        Navigator.pop(context);
        return;
      });

      return;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master
            .gestion_Message('Errore caricamento nel DB, ${error.toString()}');
        return;
      });
      return;
    }
  }
}