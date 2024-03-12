import 'package:beumed/Class/Model/Enum_SelectionView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '0.CalendarView.dart';

extension WidgetCalendar on CalendarViewState {
  Widget Title_AppBar(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Text(
      'Agenda',
      style: master.theme(size).textTheme.titleLarge,
    );
  }
}