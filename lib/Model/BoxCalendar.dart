import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beumed/Library/Extension_Date.dart';

import '../Class/EVENT.dart';
import '../Class/Master.dart';
import '../Class/BUT000.dart';
import 'EtichettaCard.dart';
import 'RowDetail.dart';

class BoxCalendar extends StatefulWidget {
  BoxCalendar({super.key});

  @override
  State<BoxCalendar> createState() => _BoxCalendarState();
}

class _BoxCalendarState extends State<BoxCalendar> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var array_hour = SelectionHour.arrayElement();

    return SizedBox(
      width: double.infinity,
      child: Card(
          margin: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var element in array_hour)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Text('${element.value}')),
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 50, right: 10),
                                    child: RowCalendar(hour: element),
                                  )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: master.theme(size).primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
              EtichettaCard(title: 'Agenda')
            ],
          )),
    );
  }

  void routeDettaglio() {
    //Navigator.pushNamed(context, SelectionView.SubContract_Dettaglio.route, arguments: RouteElement(SelectionView.SubContract_Dettaglio.value, element)).then((value) {widget.onRefresh();});
  }
}

class RowCalendar extends StatefulWidget {
  RowCalendar({super.key, required this.hour});

  late SelectionHour hour;

  @override
  State<RowCalendar> createState() => _RowCalendarState();
}

class _RowCalendarState extends State<RowCalendar> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    var event = master.array_event.firstWhere(
        (element) =>
            element.data_inizio.changeDateToString() ==
                DateTime.now().changeDateToString() &&
            element.hour == widget.hour,
        orElse: EVENT.standard);
    var user = master.array_user.firstWhere(
        (element) => element.uid == event.uidBUT000,
        orElse: BUT000.standard);

    return ElevatedButton(
        onPressed: () {},
        child: Column(
          children: [
            if (user.cf != '') Text('${user.nome} ${user.cognome}'),
            if (user.cf != '')
              Text('${user.cf}',
                  style: master.theme(size).textTheme.displaySmall),
            if (user.cf == '') Text('Crea Appuntamento'),
          ],
        ));
  }
}
