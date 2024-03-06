import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Enum_TypeDate.dart';
import 'Enum_TypeFormatDate.dart';
import 'Enum_TypeQuery.dart';


extension ExtDate on DateTime {

  DateTime addDate({ required int value, required TypeDate type}){
    switch (type) {
      case TypeDate.H:
        return this.add(Duration(hours: value));
      case TypeDate.W:
        return this.add(Duration(days: (7 * value)));
      case TypeDate.D:
        return this.add(Duration(days: value));
      case TypeDate.M:
        return  new DateTime(this.year, this.month + value, this.day);
      case TypeDate.Y:
        return  new DateTime(this.year + value, this.month, this.day);
      default:
        return this;
    }
  }

  String changeDateToString({ TypeFormatDate type = TypeFormatDate.DD_MM_AAAA }){
    return DateFormat(type.value, 'it').format(this);
  }

  int changeDateToInt({TypeFormatDate type = TypeFormatDate.AAAAMMDD}){
    var data_string =  DateFormat(type.value).format(this);
    return int.parse(data_string);
  }

  DateTime startMonth(){
    return DateTime(this.year, this.month, 1);
  }

  DateTime endMonth(){
    return DateTime(year, month + 1, 0);
  }

  bool compare(DateTime data, TypeQuery type){
    bool output = false;
    switch (type){
      case TypeQuery.EQ:
        if(this.changeDateToString() == data.changeDateToString()) output = true;
        //if(this.compareTo(data) == 0) output = true;
      case TypeQuery.LT:
        if(this.compareTo(data) < 0) output = true;
      case TypeQuery.LE:
        if(this.compareTo(data) <= 0) output = true;
      case TypeQuery.GT:
        if(this.compareTo(data) > 0) output = true;
      case TypeQuery.GE:
        if(this.compareTo(data) >= 0) output = true;
      case TypeQuery.NE:
        if(this.changeDateToString() != data.changeDateToString()) output = true;
        //if(this.compareTo(data) != 0) output = true;
    }

    return output;
  }
}

List<String> array_holiday = [
  '31/03/2024',
  '20/04/2025',
  '05/04/2026',
  '28/03/2027',
  '16/04/2028',
  '01/04/2029',
  '21/04/2030',
  '13/04/2031',
  '28/03/2032',
  '17/04/2033',
  '09/04/2034',
  '25/03/2035',
  '13/04/2036',
  '05/04/2037',
  '25/04/2038',
  '10/04/2039',
  '01/04/2040',
  '21/04/2041',
  '06/04/2042',
  '29/03/2043',
  '17/04/2044',
  '09/04/2045',
  '25/03/2046',
  '14/04/2047',
  '05/04/2048',
  '18/04/2049',
  '10/04/2050',
  '01/04/2024',
  '21/04/2025',
  '06/04/2026',
  '29/03/2027',
  '17/04/2028',
  '02/04/2029',
  '22/04/2030',
  '14/04/2031',
  '29/03/2032',
  '18/04/2033',
  '10/04/2034',
  '26/03/2035',
  '14/04/2036',
  '06/04/2037',
  '26/04/2038',
  '11/04/2039',
  '02/04/2040',
  '22/04/2041',
  '07/04/2042',
  '30/03/2043',
  '18/04/2044',
  '10/04/2045',
  '26/03/2046',
  '15/04/2047',
  '06/04/2048',
  '19/04/2049',
  '11/04/2050',
  for (int i = 2024; i <= 2050; i++) '01/01/${i}',
  for (int i = 2024; i <= 2050; i++) '06/01/${i}',
  for (int i = 2024; i <= 2050; i++) '25/04/${i}',
  for (int i = 2024; i <= 2050; i++) '01/05/${i}',
  for (int i = 2024; i <= 2050; i++) '02/06/${i}',
  for (int i = 2024; i <= 2050; i++) '15/08/${i}',
  for (int i = 2024; i <= 2050; i++) '01/11/${i}',
  for (int i = 2024; i <= 2050; i++) '08/12/${i}',
  for (int i = 2024; i <= 2050; i++) '25/12/${i}',
  for (int i = 2024; i <= 2050; i++) '26/12/${i}',
];


