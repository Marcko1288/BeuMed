import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/Library/Enum_TypeQuery.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Library/Enum_TypeExtraction.dart';
import 'HOURS.dart';

class EVENT {
  late String uid;
  late String uidBUT000;
  late DateTime data_inizio;

  //late List<SelectionHour> hours;
  late List<Hours> hours;
  late String note;
  late DateTime data_ins;
  late DateTime data_modify;

  EVENT(
      {String? uid,
      required this.uidBUT000,
      required this.data_inizio,
      required this.hours,
      String? note,
      DateTime? data_ins,
      DateTime? data_modify})
      : this.uid = uid ?? Uuid().v4().toUpperCase(),
        this.note = note ?? '',
        this.data_ins = data_ins ?? DateTime.now(),
        this.data_modify = data_modify ?? DateTime.now();

  EVENT.standard()
      : this.uidBUT000 = '',
        this.uid = '',
        this.hours = [];

  //FROM JSON
  factory EVENT.fromJson(Map<String, dynamic> json) {
    //data?['regions'] is Iterable ? List.from(data?['regions']) : null
    return EVENT(
      uid: json['uid'].runtimeType == 'String' ? json['uid'].toString() : '',
      uidBUT000: json['uidBUT000'].runtimeType == 'String'
          ? json['uidBUT000'].toString()
          : '',
      data_inizio: json['data_inizio'].runtimeType == 'String'
          ? json['data_inizio'].toString().changeStringToDate()
          : DateTime.now(),
      hours: json['hours'] is Iterable ? List.from(json['hours']) : [],
      note: json['note'].runtimeType == 'String' ? json['note'].toString() : '',
      data_ins: json['data_ins'].runtimeType == 'String'
          ? json['data_ins'].toString().changeStringToDate()
          : DateTime.now(),
      data_modify: json['data_modify'].runtimeType == 'String'
          ? json['data_modify'].toString().changeStringToDate()
          : DateTime.now(),
    );
  }

  //TO JSON
  Map<String, dynamic> toDB() => {
        'uid': uid,
        'uidBUT000': uidBUT000,
        'data_inizio': data_inizio,
        'hours': hours,
        'note': note,
        'data_ins': data_ins,
        'data_modify': data_modify
      };

  //Stampa Testata
  String printFirstLine() {
    return 'UID;UIDBUT000;Data Inizio;Orario;Note;Data Inserimento;Data Modifica';
  }

  //Stampa Elementi
  String printLine() {
    String hour = '';
    for (var element in this.hours) hour = hour + element.nome + ', ';
    return '${this.uid};'
        '${this.uidBUT000};'
        '${this.data_inizio.changeDateToString()};'
        '${hour};'
        '${this.data_ins.changeDateToString()};'
        '${this.data_modify.changeDateToString()};';
  }

  //Estrazione Single/Multy JSON
  dynamic extractionDB(
      {required Map<String, dynamic> dictionary,
      TypeExtraction type = TypeExtraction.multy}) {
    if (dictionary.isEmpty) {
      switch (type) {
        case TypeExtraction.single:
          dynamic dic = dictionary.keys.toList().first;
          return EVENT.fromJson(dic);
        case TypeExtraction.multy:
          List<EVENT> array = [];
          for (var dic in dictionary.values) {
            array.add(EVENT.fromJson(dic));
          }
          return array;
      }
    }
  }

  //Array Esempio
  static List<EVENT> arrayElement(String uid) {
    List<EVENT> array = [];

    var event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now(),
        hours: [Hours(nome: '16:00 - 17:00', number: 8)]);
    event.hours.forEach((element) {
      element.uidEVENT = event.uid;
    });

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 1)),
        hours: [
          Hours(nome: '09:00 - 10:00', number: 1),
          Hours(nome: '10:00 - 11:00', number: 2),
          Hours(nome: '11:00 - 12:00', number: 3)
        ]);
    event.hours.forEach((element) {
      element.uidEVENT = event.uid;
    });

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 2)),
        hours: [Hours(nome: '14:00 - 15:00', number: 6)]);
    event.hours.forEach((element) {
      element.uidEVENT = event.uid;
    });

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 5)),
        hours: [Hours(nome: '11:00 - 12:00', number: 3)]);

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 10)),
        hours: [Hours(nome: '11:00 - 12:00', number: 3)]);

    array.add(event);

    return array;
  }
}