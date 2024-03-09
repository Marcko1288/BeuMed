import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/View/HomeView/0.HomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/EVENT.dart';
import '../../Class/Master.dart';
import '../../Class/Model/Enum_SelectionView.dart';
import '../../Library/Enum_TypeQuery.dart';

extension FuncHome on HomeViewState {

  void refreshDate() {
    var master = Provider.of<Master>(context, listen: false);
    setState(() {
      array_hours = array_SelectionHour();
    });
  }

  List<Hours> array_SelectionHour() {
    var master = Provider.of<Master>(context, listen: false);

    //Creo L'agenda
    List<Hours> array_hours = createHours(minute: master.setting.hour);

    //Determino in quale slot sono ora
    var now_hour = detHours(minute: master.setting.hour);

    //Estraggo tutti gli eventi di oggi
    var array_event = master.array_event.where((element) => element.data_inizio.compare(DateTime.now(), TypeQuery.EQ));

    //Mi estraggo tutte le ore già fissate
    List<Hours> array_event_hours = [];
    array_event.forEach((element) {array_event_hours.addAll(element.hours);});

    //Associo lo slot con l'evento, se c'è
    array_hours.forEach((element) {
      var uidEVENT = array_event_hours.firstWhere((hour) => hour.number == element.number, orElse: Hours.standard).uidEVENT;
      element.uidEVENT = uidEVENT;
    });

    array_hours.removeWhere((element) => element.number <= now_hour);

    return array_hours;

  }

  void routeAddUser() {
    setState(() {
      Navigator.pushNamed(
          context,
          SelectionView.User.route,
          arguments: RouteElement(SelectionView.User.value, null)
      ).then((value) {refreshDate();});
    });
  }

  void routeAddEvent() {
    setState(() {
      Navigator.pushNamed(
          context,
          SelectionView.Event.route,
          arguments: RouteElement(SelectionView.Event.value, null)
      ).then((value) {refreshDate();});
    });
  }

  void routeCalendar() {
    setState(() {
      Navigator.pushNamed(
          context,
          SelectionView.History.route,
          arguments: RouteElement(SelectionView.History.value, null)
      ).then((value) {refreshDate();});
    });
  }
}