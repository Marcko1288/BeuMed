import 'package:beumed/Library/Extension_Date.dart';
import 'package:flutter/material.dart';

import '../Library/Enum_TypeQuery.dart';

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

List<Hours> createHours({int minute = 30}) {
  List<Hours> array_output = [];

  DateTime hour_min = DateTime(1990, 01, 01, 09, 00, 00);
  DateTime hour_max = DateTime(1990, 01, 01, 19, 00, 00);

  DateTime hour_da = DateTime(1990, 01, 01, 13, 00, 00, 01);
  DateTime hour_a = DateTime(1990, 01, 01, 14, 00, 00, 01);

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
  array_output.sort((a, b) => a.number.compareTo(b.number));

  return array_output;
}

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
  return output;
}
