import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Library/Enum_TypeExtraction.dart';

class EVENT {
  late String uid;
  late String uidBUT000;
  late DateTime data_inizio;
  late SelectionHour hour;
  late String note;
  late DateTime data_ins;
  late DateTime data_modify;

  EVENT({
    String? uid,
    required this.uidBUT000,
    required this.data_inizio,
    required this.hour,
    String? note,
    DateTime? data_ins,
    DateTime? data_modify
  }) : this.uid = uid ?? Uuid().v4().toUpperCase(),
        this.note = note ?? '',
        this.data_ins = data_ins ?? DateTime.now(),
        this.data_modify = data_modify ?? DateTime.now();

  EVENT.standard({
    this.uidBUT000 = ''
  });

  //FROM JSON
  factory EVENT.fromJson(Map<String, dynamic> json) {
    return EVENT(
        uid: json['uid'].runtimeType == 'String' ? json['uid'].toString() : '',
        uidBUT000: json['uidBUT000'].runtimeType == 'String' ? json['uidBUT000'].toString() : '',
        data_inizio: json['data_inizio'].runtimeType == 'String' ? json['data_inizio'].toString().changeStringToDate() : DateTime.now(),
        hour: json['hour'].runtimeType == 'String' ? SelectionHour.code(json['hour'].toString()) : SelectionHour.H1,
        note: json['note'].runtimeType == 'String' ? json['note'].toString() : '',
        data_ins: json['data_ins'].runtimeType == 'String' ? json['data_ins'].toString().changeStringToDate() : DateTime.now(),
        data_modify: json['data_modify'].runtimeType == 'String' ? json['data_modify'].toString().changeStringToDate() : DateTime.now(),
    );
  }

  //TO JSON
  Map<String, dynamic> toDB() => {
  'uid' : uid,
  'uidBUT000': uidBUT000,
  'data_inizio': data_inizio,
  'hour': hour,
  'note': note,
  'data_ins': data_ins,
  'data_modify': data_modify
  };

  //Stampa Testata
  String printFirstLine() {
    return 'UID;UIDBUT000;Data Inizio;Orario;Note;Data Inserimento;Data Modifica';
  }

  //Stampa Elementi
  String printLine(){
    return '${this.uid};'
        '${this.uidBUT000};'
        '${this.data_inizio.changeDateToString()};'
        '${this.hour.value};'
        '${this.data_ins.changeDateToString()};'
        '${this.data_modify.changeDateToString()};';
  }

  //Estrazione Single/Multy JSON
  dynamic extractionDB({required Map<String, dynamic> dictionary, TypeExtraction type = TypeExtraction.multy}) {
    if (dictionary.isEmpty) {
      switch (type) {
        case TypeExtraction.single:
          dynamic dic = dictionary.keys.toList().first;
          return EVENT.fromJson(dic);
        case TypeExtraction.multy:
          List<EVENT> array = [];
          for( var dic in dictionary.values) {
            array.add(EVENT.fromJson(dic));
          }
          return array;
      }
    }
  }

  //Array Esempio
  static List<EVENT> arrayElement(String uid){
    List<EVENT> array = [];
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now(), hour: SelectionHour.H1)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now(), hour: SelectionHour.H5)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now(), hour: SelectionHour.H3)
    );

    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H1)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H2)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H3)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H4)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H5)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H6)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H7)
    );
    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H8)
    );

    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H9)
    );

    array.add(
        EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 10)), hour: SelectionHour.H3)
    );
    return array;
  }


}

