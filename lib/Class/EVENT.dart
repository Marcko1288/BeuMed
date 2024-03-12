import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/Library/Enum_TypeQuery.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Library/Enum_TypeExtraction.dart';

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
          Hours(nome: '09:00 - 09:30', number: 1),
          Hours(nome: '09:30 - 10:00', number: 2),
          Hours(nome: '10:00 - 10:30', number: 3)
        ]);
    event.hours.forEach((element) {
      element.uidEVENT = event.uid;
    });

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 2)),
        hours: [Hours(nome: '11:00 - 11:30', number: 5)]);
    event.hours.forEach((element) {
      element.uidEVENT = event.uid;
    });

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 5)),
        hours: [Hours(nome: '10:00 - 10:30', number: 3)]);

    array.add(event);

    event = EVENT(
        uidBUT000: uid,
        data_inizio: DateTime.now().add(Duration(days: 10)),
        hours: [Hours(nome: '10:00 - 10:30', number: 3)]);

    array.add(event);
    //
    // array.add(EVENT(
    //     uidBUT000: uid,
    //     data_inizio: DateTime.now().add(Duration(days: 1)),
    //     hours: [
    //       Hours(nome: '09:00 - 09:30', number: 1, uidEVENT: ),
    //       Hours(nome: '09:30 - 10:00', number: 2),
    //       Hours(nome: '10:00 - 10:30', number: 3)
    //     ]));
    //
    // array.add(EVENT(
    //     uidBUT000: uid,
    //     data_inizio: DateTime.now().add(Duration(days: 2)),
    //     hours: [Hours(nome: '11:00 - 11:30', number: 5)]));
    //
    // array.add(EVENT(
    //     uidBUT000: uid,
    //     data_inizio: DateTime.now().add(Duration(days: 5)),
    //     hours: [Hours(nome: '10:00 - 10:30', number: 3)]));
    //
    // array.add(EVENT(
    //     uidBUT000: uid,
    //     data_inizio: DateTime.now().add(Duration(days: 10)),
    //     hours: [Hours(nome: '10:00 - 10:30', number: 3)]));
    // array.add(
    //     EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H4)
    // );
    // array.add(
    //     EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H5)
    // );
    // array.add(
    //     EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H6)
    // );
    // array.add(
    //     EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H7)
    // );
    // array.add(
    //     EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H8)
    // );

    // // array.add(
    // //     EVENT(uidBUT000: uid, data_inizio: DateTime.now().add(Duration(days: 3)), hour: SelectionHour.H9)
    // // );{

    return array;
  }
}

class Hours {
  late String nome;
  late int number;
  late String uidEVENT;

  Hours({
    required this.nome,
    required this.number,
    String? uidEVENT,
  }) : this.uidEVENT = uidEVENT ?? '';

  Hours.standard()
      : this.nome = '',
        this.number = 0,
        this.uidEVENT = '';
}

// List<Hours> createHours({int minute = 30}) {
//   List<Hours> array_output = [];

//   DateTime data_m_da = DateTime(1990, 01, 01, 09, 00, 00);
//   DateTime data_m_a = DateTime(1990, 01, 01, 13, 00, 01);

//   DateTime data_p_da = DateTime(1990, 01, 01, 14, 00, 01);
//   DateTime data_p_a = DateTime(1990, 01, 01, 19, 00, 00);

//   int dim = (data_p_a.difference(data_m_da).inMinutes / minute).toInt();

//   for (var i = 1; i <= dim; i++) {
//     var data_now = data_m_da.add(Duration(minutes: minute));
//     if (data_now.compareTo(data_m_a) <= 0 || //data_now <= data_m_a
//         data_p_da.compareTo(data_now) <= 0) {
//       //data_p_da <= data_now
//       if (data_now.compareTo(data_p_a) <= 0) {
//         //data_now <= data_p_a
//         var nome =
//             '${data_m_da.hour.toString().padLeft(2, '0')}:${data_m_da.minute.toString().padLeft(2, '0')} '
//             '- '
//             '${data_now.hour.toString().padLeft(2, '0')}:${data_now.minute.toString().padLeft(2, '0')}';
//         array_output.add(Hours(nome: nome, number: i));
//       }
//     }
//     data_m_da = data_now;
//   }

//   array_output.sort((a, b) => a.number.compareTo(b.number));

//   return array_output;
// }
//
List<Hours> createHours({int minute = 30}) {
  List<Hours> array_output = [];

  DateTime hour_min = DateTime(1990, 01, 01, 09, 00, 00);
  DateTime hour_max = DateTime(1990, 01, 01, 19, 00, 00);

  DateTime hour_da = DateTime(1990, 01, 01, 13, 00, 00);
  DateTime hour_a = DateTime(1990, 01, 01, 13, 59, 59);

  int dim = (hour_max.difference(hour_min).inMinutes / minute).toInt();

  for (var i = 1; i <= dim; i++) {
    var det_hour = hour_min.add(Duration(minutes: minute));

    if (det_hour.compare(hour_min, TypeQuery.GE) &&
        det_hour.compare(hour_max, TypeQuery.LE)) {
      if (det_hour.compare(hour_da, TypeQuery.LE) ||
          det_hour.compare(hour_a, TypeQuery.GE)) {
        var nome =
            '${hour_min.hour.toString().padLeft(2, '0')}:${hour_min.minute.toString().padLeft(2, '0')} '
            '- '
            '${det_hour.hour.toString().padLeft(2, '0')}:${det_hour.minute.toString().padLeft(2, '0')}';
        array_output.add(Hours(nome: nome, number: i));
      }
    }
    hour_min = det_hour;
  }

  array_output.forEach((element) {
    print('${element.nome} - ${element.number}');
  });

  array_output.sort((a, b) => a.number.compareTo(b.number));

  return array_output;
}

// int detHours({int minute = 30}) {
//   var now = DateTime.now();
//   var output = 12;
//   DateTime data_m_da = DateTime(now.year, now.month, now.day, 09, 00, 00);
//   DateTime data_m_a = DateTime(now.year, now.month, now.day, 13, 00, 00);

//   DateTime data_p_da = DateTime(now.year, now.month, now.day, 14, 00, 00);
//   DateTime data_p_a = DateTime(now.year, now.month, now.day, 19, 00, 00);

//   int dim = (data_p_a.difference(data_m_da).inMinutes / minute).toInt();
//   int sub = (data_p_da.difference(data_m_a).inMinutes / minute).toInt();

//   for (var i = 0; i <= dim; i++) {
//     var data_now = data_m_da.add(Duration(minutes: i * minute));

//     if (now.compare(data_m_da, TypeQuery.GE) &&
//         now.compare(data_p_a, TypeQuery.LE)) {
//       if (now.compare(data_m_da, TypeQuery.GE) &&
//           now.compare(data_m_a, TypeQuery.LE)) {
//         if (now.compare(data_m_da, TypeQuery.LE) &&
//             now.compare(data_now, TypeQuery.GE)) {
//           output = i - sub;
//           break;
//         }
//         if (data_now.compare(data_m_da, TypeQuery.GT)) data_m_da = data_now;
//       } else if (now.compare(data_p_da, TypeQuery.GE) &&
//           now.compare(data_p_a, TypeQuery.LE)) {
//         if (now.compare(data_p_da, TypeQuery.GE) &&
//             now.compare(data_now, TypeQuery.LE)) {
//           output = i - sub;
//           break;
//         }
//         if (data_now.compare(data_p_da, TypeQuery.GT)) data_p_da = data_now;
//       }
//     }
//   }
//   return output;
// }
//
int detHours({int minute = 30}) {
  var now = DateTime.now();
  var output = 24;

  DateTime hour_min = DateTime(now.year, now.month, now.day, 09, 00, 00);
  DateTime hour_max = DateTime(now.year, now.month, now.day, 19, 00, 00);

  DateTime hour_da = DateTime(now.year, now.month, now.day, 13, 00, 00);
  DateTime hour_a = DateTime(now.year, now.month, now.day, 13, 59, 59);

  int dim = (hour_max.difference(hour_min).inMinutes / minute).toInt();

  for (var i = 1; i <= dim; i++) {
    var det_hour = hour_min.add(Duration(minutes: minute));
    if (det_hour.compare(hour_min, TypeQuery.GE) &&
        det_hour.compare(hour_max, TypeQuery.LE)) {
      if (det_hour.compare(hour_da, TypeQuery.LE) ||
          det_hour.compare(hour_a, TypeQuery.GE)) {
        if (now.compare(hour_min, TypeQuery.GE) &&
            now.compare(det_hour, TypeQuery.LE)) {
          output = i;
          break;
        }
      }
    }
    hour_min = det_hour;
  }
  print('output: ${output}');
  return output;
}
