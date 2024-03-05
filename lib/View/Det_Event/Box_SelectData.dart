import 'package:beumed/View/Det_Event/0.Det_Event.dart';
import 'package:beumed/View/Det_Event/2.FunctionDet_Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Model/DatePickerApp.dart';
import '../../Class/Model/Enum_TypeState.dart';

extension BoxSelectData on Det_EventViewState {
  //Seleziona Data
  Widget SelectDataEvent(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return DatePickerCustom(
      selection_date: data_inizio,
      min_year: DateTime.now().year,
      max_year: DateTime.now().add(Duration(days: 730)).year,
      array_nodate: array_noDate,
      text_labol: 'Appuntamento',
      enable: widget.state == TypeState.read ? false : true,
      onDateTimeChanged: (DateTime value) {
        setState(() {
          data_inizio = value;
          creatTime(data_inizio);
        });
      },
    );
  }
}
