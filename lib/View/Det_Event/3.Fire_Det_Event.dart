import 'package:beumed/View/Det_Event/0.Det_Event.dart';
import 'package:beumed/View/Det_Event/2.Function_Det_Event.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../Class/HOURS.dart';
import '../../Class/Master.dart';
import '../../Class/EVENT.dart';
import '../../Library/FireAuth.dart';
import '../../Library/FireStore.dart';
import '../../Class/Model/Enum_TypeState.dart';

extension FireDetEvent on Det_EventViewState {
  Future<void> insertElement() async {
    var master = Provider.of<Master>(context, listen: false);
    bool insert = true;

    if (insert == true) {
      var event = EVENT(
          uidBUT000: userSelected.uid,
          data_inizio: data_inizio,
          hours: [],
          note: note);

      isTimeSelection.forEach((element) {
        var hour = Hours(nome: element.nome, number: element.number, uidEVENT: event.uid);
        event.hours.add(hour);
      });

      try {
        var dirDB = FireStore()
            .dirDB(document: '${Auth().currentUser!.uid}', value: 'EVENT');
        var element_map = event.toDB();
        await FireStore().insertFirestore(patch: dirDB, map: element_map);
        print('Caricamento OK');
        widget.event = event;
        master.array_event.add(event);

        setState(() {
          master.gestion_Message('Dati caricati correttamente');
          widget.state = TypeState.read;
          refreshDate(context);
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
    var index = master.array_event
        .indexWhere((element) => element.uid == widget.event!.uid);
    master.array_event[index].data_inizio = data_inizio;
    master.array_event[index].hours = isTimeSelection;
    master.array_event[index].hours.forEach((element) {
      element.uidEVENT = master.array_event[index].uid;
    });
    master.array_event[index].note = note;

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'EVENT');
      var element_map = master.array_event[index].toDB();
      await FireStore().modifyFireStore(patch: dirDB, map: element_map);
      print('Modifica OK');

      setState(() {
        master.gestion_Message('Dati modificati correttamente');
        widget.state = TypeState.read;
        refreshDate(context);
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
    var index = master.array_event
        .indexWhere((element) => element.uid == widget.event!.uid);

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'EVENT');
      var element_map = master.array_event[index].toDB();
      await FireStore().cancelFireStore(patch: dirDB, map: element_map);
      print('Cancellazione OK');

      master.array_event.removeAt(index);

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
