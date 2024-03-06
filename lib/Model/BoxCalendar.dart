import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beumed/Library/Extension_Date.dart';

import '../Class/EVENT.dart';
import '../Class/Master.dart';
import '../Class/BUT000.dart';
import '../Class/Model/Enum_SelectionView.dart';
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
    var array_hour = array_SelectionHour();

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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (array_hour.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text('Nessun Appuntamento',
                                  style:
                                      master.theme(size).textTheme.titleMedium),
                            ),
                          if (array_hour.isNotEmpty)
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
                                        onPressed: null,
                                        child: Text('${element.nome}'),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 50, right: 10),
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
                              ),
                          Container(
                            width: size.width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Visualizza Agenda'),
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all(
                                    master.theme(size).textTheme.labelLarge),
                                backgroundColor: MaterialStateProperty.all(
                                    master.theme(size).primaryColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              EtichettaCard(
                  title: 'Agenda - ${DateTime.now().changeDateToString()}')
            ],
          )),
    );
  }

  // List<SelectionHour> array_SelectionHour() {
  //   List<SelectionHour> array_output = [];
  //   var now_hour = SelectionHour.hour(DateTime.now());
  //   for (var element in SelectionHour.arrayElement()) {
  //     if (element.number >= now_hour.number) array_output.add(element);
  //   }
  //   return array_output;
  // }

  List<Hours> array_SelectionHour() {
    var master = Provider.of<Master>(context, listen: false);
    List<Hours> array_output = createHours(minute: master.setting.hour);
    var now_hour = detHours(minute: master.setting.hour);
    array_output.removeWhere((element) => element.number <= now_hour);

    var array_event_app = master.array_event.where((element) =>
        element.data_inizio.changeDateToString() ==
        DateTime.now().changeDateToString());
    List<Hours> array_hour_app = [];
    array_event_app.forEach((element) {
      array_hour_app.addAll(element.hours);
    });
    print('array_event_app: ${array_event_app.length}');
    print('array_hour_app: ${array_hour_app.length}');
    array_output.forEach((element) {
      var hour = array_hour_app.firstWhere(
          (ele) => ele.number == element.number,
          orElse: () => Hours(nome: '', number: 0));
      print('hour: ${hour.uidEVENT}');
      element.uidEVENT = hour.uidEVENT;
    });

    return array_output;
  }
}

class RowCalendar extends StatefulWidget {
  RowCalendar({super.key, required this.hour});

  late Hours hour;

  @override
  State<RowCalendar> createState() => _RowCalendarState();
}

class _RowCalendarState extends State<RowCalendar> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    var event = master.array_event.firstWhere(
        (element) => element.uid == widget.hour.uidEVENT,
        orElse: EVENT.standard);
    var user = master.array_user.firstWhere(
        (element) => element.uid == event.uidBUT000,
        orElse: BUT000.standard);

    print('event: ${event.uid}');

    return ElevatedButton(
        onPressed: user.cf == ''
            ? () {
                routeAddEvent();
              }
            : () {
                routeSelectUser(user);
              },
        child: Column(
          children: [
            if (user.uid != '') Text('${user.nome} ${user.cognome}'),
            if (user.uid != '')
              Text('${user.cf}',
                  style: master.theme(size).textTheme.displaySmall),
            if (user.uid == '') Text('Crea Appuntamento'),
          ],
        ));
  }

  void routeAddEvent() {
    setState(() {
      Navigator.pushNamed(context, SelectionView.Event.route,
          arguments: RouteElement(SelectionView.Event.value, null));
    });
  }

  void routeSelectUser(BUT000 element) {
    Navigator.pushNamed(context, SelectionView.User.route,
        arguments: RouteElement(SelectionView.User.value, element));
  }
}
