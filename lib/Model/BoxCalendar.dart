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
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var element in array_hour)
                          Container(
                              padding: EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${element.value}'),
                                    RowCalendar(hour: element)
                                  ],
                                ),
                              ))

                        // for(var element in widget.array)
                        //   ElevatedButton(
                        //     onPressed: () { routeDettaglio(); }, //() => { /* DA COMPLETARE */ },
                        //     style: ButtonStyle(
                        //         backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        //         foregroundColor: MaterialStateProperty.all(Colors.black),
                        //         elevation:  MaterialStateProperty.all(0),
                        //         overlayColor:  MaterialStateProperty.all(Colors.grey[200]),
                        //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        //             RoundedRectangleBorder(
                        //                 borderRadius:BorderRadius.circular(18.0),
                        //                 side: BorderSide(color: Colors.transparent)
                        //             )
                        //         )
                        //     ),
                        //     child: RowDetail(
                        //         title:
                        //         '${element.nome} ${element.cognome}',
                        //         body:
                        //         'Appuntamento: 12/01/2024 12:30 \nCF: ${element.cf} \n@: ${element.mail}',
                        //         iconrow: Icons.connected_tv_outlined
                        //     ),
                        //   ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20),
                        //   child: ElevatedButton(
                        //     onPressed: widget.onPressed, //() => { /* DA COMPLETARE */ },
                        //     child: Text('Dettagli'),
                        //     style: ButtonStyle(
                        //       padding: MaterialStateProperty.all( EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20) ),
                        //       shape: MaterialStateProperty.all( RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20) ) ),
                        //     ),
                        //   ),
                        // ),
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
    var event = master.array_event.firstWhere((element) =>
            element.hour == widget.hour &&
            element.data_inizio.changeDateToString() ==
                DateTime.now().changeDateToString()) ??
        EVENT.standard();
    var user = master.array_user
            .firstWhere((element) => element.uid == event.uidBUT000) ??
        BUT000.standard();

    if (user.cf == '') {
      return ElevatedButton(
        onPressed: () {},
        child: Text('Crea Appuntamento'),
      );
    } else {
      return ElevatedButton(
          onPressed: () {},
          child: Column(
            children: [
              Text('${user.nome} ${user.cognome}'),
              Text('${user.cf}', style: ThemeData().textTheme.bodySmall),
            ],
          ));
    }
  }
}
