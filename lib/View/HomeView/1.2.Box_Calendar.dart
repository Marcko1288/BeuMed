import 'package:beumed/Class/BUT000.dart';
import 'package:beumed/Class/EVENT.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Model/CardBox/CardBox.dart';
import 'package:beumed/Model/RowCalendar.dart';
import 'package:beumed/View/HomeView/0.HomeView.dart';
import 'package:beumed/View/HomeView/2.Function_Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/HOURS.dart';
import '../../Class/Master.dart';

extension BoxCalendar on HomeViewState {
  Widget BoxAgenda(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return CardBox(
      text_card: 'Agenda - ${DateTime.now().changeDateToString()}',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (array_hours.isEmpty)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Nessun Appuntamento',
                  style: master.theme(size).textTheme.titleMedium),
            ),
          if (array_hours.isNotEmpty)
            Column(
              children: List<Widget>.generate(array_hours.length, (index) {
                Hours hour = array_hours[index];
                EVENT event = master.array_event.firstWhere(
                    (element) => element.uid == hour.uidEVENT,
                    orElse: EVENT.standard);
                BUT000 user = master.array_user.firstWhere(
                    (element) => element.uid == event.uidBUT000,
                    orElse: BUT000.standard);

                String title = user.uid != ''
                    ? '${user.nome} ${user.cognome}'
                    : 'Crea Appuntamento';
                String? body = user.uid != '' ? '${user.cf}' : null;
                var funct = user.uid != ''
                    ? () {
                        routeAddUser(user);
                      }
                    : () {
                        routeAddEvent();
                      };

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ))),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: master.theme(size).primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            ),
          Container(
            width: size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {
                routeCalendar();
              },
              child: Text('Visualizza Agenda'),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    master.theme(size).textTheme.labelLarge),
                backgroundColor:
                    MaterialStateProperty.all(master.theme(size).primaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
