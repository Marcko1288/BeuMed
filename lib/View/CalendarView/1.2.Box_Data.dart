import 'package:beumed/View/CalendarView/2.Function_Calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Model/DatePickerApp.dart';
import '0.CalendarView.dart';

extension BoxData on CalendarViewState {

  Widget SelectData(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return DatePickerCustom(
      selection_date: select_data,
      min_year: DateTime.now().year,
      max_year: DateTime.now().add(Duration(days: 730)).year,
      onDateTimeChanged: (DateTime value) {
        setState(() {
          select_data = value;
          refreshDate();
        });
      },
    );
  }
}