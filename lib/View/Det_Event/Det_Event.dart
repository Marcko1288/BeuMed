import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/View/Det_Event/FireDet_Event.dart';
import 'package:beumed/View/Det_Event/FunctionDet_Event.dart';
import 'package:beumed/View/Det_Event/WidgetDet_Event.dart';
import 'package:beumed/View/Det_Event/Box_SelectUser.dart';
import 'package:beumed/View/Det_Event/Box_SelectData.dart';
import 'package:beumed/View/Det_Event/Box_SelectHours.dart';
import 'package:beumed/View/Det_Event/Box_Note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/BUT000.dart';
import '../../Class/EVENT.dart';
import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeState.dart';

class Det_EventView extends StatefulWidget {
  Det_EventView({super.key, this.state = TypeState.read, this.event});

  late EVENT? event;
  late TypeState state;

  @override
  State<Det_EventView> createState() => Det_EventViewState();
}

class Det_EventViewState extends State<Det_EventView> {
  late BUT000 userSelected = BUT000.standard();
  late DateTime data_inizio = DateTime.now();
  late String note = '';

  final formKey = GlobalKey<FormState>();

  List<String> array_noDate = [];
  List<Hours> isTime = [];
  List<Hours> isTimeSelection = [];

  @override
  void initState() {
    super.initState();
    refreshDate(context);
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Title_AppBar(context),
        ),
        actions: [
          if (widget.state != TypeState.insert)
            IconButton(
                onPressed: deleteElement,
                icon: Icon(Icons.delete_forever_outlined)),
        ],
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SelectUser(context),
              SelectDataEvent(context),
              SelectHour(context),
              InsertNote(context),
            ],
          ),
        ),
      ),
      floatingActionButton: action_button(context),
    );
  }

  // List<String> selectionNoDate() {
  //   //Crea un array di date in cui tutti gli appuntamenti sono già fissati.
  //   var master = Provider.of<Master>(context, listen: false);
  //   var array = master.array_event;
  //   List<String> array_output = [];
  //   array.sort((a, b) => (a.data_inizio.compareTo(b.data_inizio)));
  //   String selectDate = '';

  //   for (var element in array) {
  //     if (selectDate != element.data_inizio.changeDateToString()) {
  //       var length = master.array_event
  //           .where((elem) =>
  //               elem.data_inizio.changeDateToString() ==
  //               element.data_inizio.changeDateToString())
  //           .length;
  //       if (length >= 9) {
  //         array_output.add(element.data_inizio.changeDateToString());
  //       }
  //       selectDate = element.data_inizio.changeDateToString();
  //     }
  //   }
  //   return array_output;
  // }

  // void create_arrayHour(DateTime now_date) {
  //   var master = Provider.of<Master>(context, listen: false);
  //   var now_hour = SelectionHour.hour(DateTime.now());

  //   var array_app = master.array_event
  //       .where((element) =>
  //           element.data_inizio.changeDateToString() ==
  //           now_date.changeDateToString())
  //       .toList();
  //   isTime = SelectionHour.arrayElement();

  //   array_app.forEach((element) {
  //     print(element.printLine());
  //   });

  //   for (var element in array_app) {
  //     for (var hour in element.hours)
  //       isTime.removeWhere((eleTime) => eleTime == hour);
  //   }

  //   if (DateTime.now().changeDateToString() == now_date.changeDateToString())
  //     isTime.removeWhere((element) => element.number <= now_hour.number);

  //   if (userSelected.uidBUT000 != '') {
  //     var event_user = array_app.firstWhere(
  //         (element) => element.uidBUT000 == userSelected.uid,
  //         orElse: EVENT.standard);

  //     if (event_user.uidBUT000 != '') {
  //       var hours = event_user.hours.toList();
  //       isTime.addAll(hours);
  //       isTimeSelection.clear();
  //       isTimeSelection.addAll(hours);
  //       widget.event = event_user;
  //     }
  //   }

  //   isTime.sort((a, b) => a.number.compareTo(b.number));
  // }
}

// OutlineInputBorder defaultBorder(Color color) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(20)),
//     borderSide: BorderSide(color: color),
//   );
// }
