import 'package:beumed/Class/EVENT.dart';
import 'package:beumed/View/Det_Event/0.Det_Event.dart';
import 'package:beumed/View/Det_Event/3.Fire_Det_Event.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Model/Enum_TypeState.dart';
import '../../Class/Master.dart';
import '../../Class/BUT000.dart';

extension FuncDetEvent on Det_EventViewState {
  String Title_Button() {
    switch (widget.state) {
      case TypeState.read:
        return 'Modifica Appuntamento';
      case TypeState.insert:
        return 'Salva Appuntamento';
      case TypeState.modify:
        return 'Salva Appuntamento';
    }
  }

  void refreshDate(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    setState(() {
      var state = widget.state == TypeState.insert ? true : false;

      userSelected = state
          ? BUT000.standard()
          : master.array_user.firstWhere(
              (element) => element.uid == widget.event!.uidBUT000,
              orElse: BUT000.standard);
      data_inizio = state ? detSelectionDate() : widget.event!.data_inizio;
      note = state ? '' : widget.event!.note;
      array_noDate = selectionNoDate();
      creatTime(data_inizio);
      // isTime = createIsTime(data_inizio);
      // isTimeSelection =
      //     state ? [] : createIsSelectionTime(data_inizio, userSelected);

      // if (widget.state == TypeState.insert) {
      //   data_inizio = detSelectionDate();
      //   note = '';
      // } else {
      //   userSelected = master.array_user.firstWhere(
      //       (element) => element.uid == widget.event!.uidBUT000,
      //       orElse: BUT000.standard);
      //   data_inizio = widget.event!.data_inizio;
      //   note = widget.event!.note;
      // }
      // create_arrayHour(data_inizio);
      // array_noDate = selectionNoDate();
    });
  }

  DateTime detSelectionDate() {
    var array_no_date = array_holiday;
    array_no_date.addAll(array_noDate);
    var date_output = data_inizio;
    array_no_date.sort((a, b) => a.compareTo(b));

    if (date_output.weekday == 6)
      date_output = date_output.add(Duration(days: 2));
    if (date_output.weekday == 7)
      date_output = date_output.add(Duration(days: 1));

    for (var element in array_no_date) {
      if (element.changeStringToDate().year > date_output.year) break;
      if (element == date_output.changeDateToString())
        date_output.add(Duration(days: 1));
    }
    return date_output;
  }

  List<String> selectionNoDate() {
    //Crea un array di date in cui tutti gli appuntamenti sono già fissati.
    var master = Provider.of<Master>(context, listen: false);
    var array = master.array_event;
    List<String> array_output = [];
    array.sort((a, b) => (a.data_inizio.compareTo(b.data_inizio)));
    String selectDate = '';

    for (var element in array) {
      if (selectDate != element.data_inizio.changeDateToString()) {
        var length = master.array_event
            .where((elem) =>
                elem.data_inizio.changeDateToString() ==
                element.data_inizio.changeDateToString())
            .length;
        if (length >= 9) {
          array_output.add(element.data_inizio.changeDateToString());
        }
        selectDate = element.data_inizio.changeDateToString();
      }
    }
    return array_output;
  }

  void creatTime(DateTime selectData) {
    var master = Provider.of<Master>(context, listen: false);
    var hours = createHours(minute: master.setting.hour);
    var now = detHours(minute: master.setting.hour);
    var events = master.array_event
        .where((element) =>
            element.data_inizio.changeDateToString() ==
            selectData.changeDateToString())
        .toList();

    List<Hours> uidApp = [];
    isTime.clear();
    isTimeSelection.clear();
    print('PRE -> hours: ${hours.length} - events: ${events.length}  ');

    events.forEach((element) {
      element.hours.forEach((elem) {
        var index = hours.indexWhere((hour) => hour.number == elem.number);
        if (index >= 0) hours[index].uidEVENT = element.uid;
      });
    });

    print('POST -> hours: ${hours.length} - events: ${events.length}  ');

    isTime = hours.where((element) => element.uidEVENT == '').toList();

    print('isTime: ${isTime.length} - now: ${now}  ');
    if (selectData.changeDateToString() ==
        DateTime.now().changeDateToString()) {
      isTime.removeWhere((element) => element.number < now);
    }

    if (userSelected.uid != '') {
      var event = events.firstWhere(
          (element) => element.uidBUT000 == userSelected.uid,
          orElse: EVENT.standard);
      if (event.uid != '') {
        isTimeSelection =
            hours.where((element) => element.uidEVENT == event.uid).toList();
        isTime.addAll(isTimeSelection);
      }
    }

    isTime.sort((a, b) => a.number.compareTo(b.number));
    isTimeSelection.sort((a, b) => a.number.compareTo(b.number));
  }

  // List<Hours> createIsTime(DateTime selectData) {
  //   var master = Provider.of<Master>(context, listen: false);
  //
  //   var hours = createHours(minute: master.setting.hour);
  //   var events = master.array_event
  //       .where((element) =>
  //           element.data_inizio.changeDateToString() ==
  //           selectData.changeDateToString())
  //       .toList();
  //
  //   events.forEach((element) {
  //     element.hours.forEach((elem) {
  //       var index = hours.indexWhere((hour) => hour.number == elem.number);
  //       if (index >= 0) hours[index].uidEVENT = element.uid;
  //     });
  //   });
  //   hours.forEach((element) {print('createIsTime: ${element.nome} - ${element.uidEVENT}');});
  //   return hours;
  // }
  //
  // List<Hours> createIsSelectionTime(DateTime selectData, BUT000 user) {
  //   var master = Provider.of<Master>(context, listen: false);
  //
  //   var hours = master.array_event
  //       .firstWhere(
  //           (element) =>
  //               element.data_inizio.changeDateToString() ==
  //                   selectData.changeDateToString() &&
  //               element.uidBUT000 == user.uid,
  //           orElse: EVENT.standard)
  //       .hours;
  //
  //   hours.forEach((element) {print('createIsSelectionTime: ${element.nome} - ${element.uidEVENT}');});
  //
  //   return hours;
  // }

  Future<void> actionElement() async {
    var master = Provider.of<Master>(context, listen: false);

    if (formKey.currentState!.validate()) {
      if (widget.state == TypeState.read) {
        setState(() {
          widget.state = TypeState.modify;
        });
      } else {
        if (widget.state == TypeState.insert) {
          if (widget.event == null) {
            await insertElement();
          } else {
            await modifyElement();
          }
        }
        if (widget.state == TypeState.modify) {
          await modifyElement();
        }
      }
    }
  }
}
