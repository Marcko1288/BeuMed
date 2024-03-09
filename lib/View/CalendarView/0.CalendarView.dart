import 'package:beumed/View/CalendarView/1.1.Widget_Calendar.dart';
import 'package:beumed/View/CalendarView/1.2.Box_Data.dart';
import 'package:beumed/View/CalendarView/1.3.Box_Slot.dart';
import 'package:beumed/View/CalendarView/2.Function_Calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/EVENT.dart';
import '../../Class/Master.dart';

class CalendarView extends StatefulWidget {
  CalendarView({super.key});

  @override
  State<CalendarView> createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarView> {

  late DateTime select_data = DateTime.now();
  late List<Hours> array_hours = [];

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Title_AppBar(context),
        ),
        actions: [],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SelectData(context),
                  SelectSlot(context),
                  Container(
                    height: size.height * 0.1,
                  )
                ],
              )),
        ),
      ),
    );
  }
}
