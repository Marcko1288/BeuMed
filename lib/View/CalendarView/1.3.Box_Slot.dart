import 'package:beumed/View/CalendarView/0.CalendarView.dart';
import 'package:beumed/View/CalendarView/2.Function_Calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/BUT000.dart';
import '../../Class/EVENT.dart';
import '../../Class/Master.dart';
import '../../Model/RowCalendar.dart';

extension BoxSlot on CalendarViewState {
  Widget SelectSlot(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Column(
      children: List<Widget>.generate(array_hours.length, (index) {
      Hours hour = array_hours[index];
      EVENT event = master.array_event.firstWhere((element) => element.uid == hour.uidEVENT, orElse: EVENT.standard);
      BUT000 user = master.array_user.firstWhere((element) => element.uid == event.uidBUT000, orElse: BUT000.standard);

      String title = user.uid != '' ? '${user.nome} ${user.cognome}' : 'Crea Appuntamento';
      String? body = user.uid != '' ? '${user.cf}' : null;
      var funct = user.uid != '' ? () {routeAddUser();} : () {routeAddEvent();};

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: null,
                child: Text('${hour.nome}'),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 50, right: 10),
                      child: ElevatedButton(
                        onPressed: funct,
                        child: RowCalendar(
                          title_text: title,
                          body_text: body,
                        ),
                      )
                  )
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: master.theme(size).primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }),
    );
  }
}