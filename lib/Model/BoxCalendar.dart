// import 'package:beumed/Class/Model/Enum_Hour.dart';
// import 'package:beumed/Library/Enum_TypeQuery.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:beumed/Library/Extension_Date.dart';
//
// import '../Class/EVENT.dart';
// import '../Class/Master.dart';
// import '../Class/BUT000.dart';
// import '../Class/Model/Enum_SelectionView.dart';
// import 'CardBox/EtichettaCard.dart';
//
// class BoxCalendar extends StatefulWidget {
//   BoxCalendar({super.key});
//
//   @override
//   State<BoxCalendar> createState() => _BoxCalendarState();
// }
//
// class _BoxCalendarState extends State<BoxCalendar> {
//
//   var array_hour = [];
//
//   @override
//   void initState() {
//     super.initState();
//     refreshDate(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var master = Provider.of<Master>(context, listen: false);
//     var size = MediaQuery.of(context).size;
//
//     return SizedBox(
//       width: double.infinity,
//       child: Card(
//           margin: EdgeInsets.all(20),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           child: Stack(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           if (array_hour.isEmpty)
//                             Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Text('Nessun Appuntamento',
//                                   style:
//                                       master.theme(size).textTheme.titleMedium),
//                             ),
//                           if (array_hour.isNotEmpty)
//                             for (var element in array_hour)
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ElevatedButton(
//                                         onPressed: null,
//                                         child: Text('${element.nome}'),
//                                       ),
//                                       Expanded(
//                                           child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 50, right: 10),
//                                         child: RowCalendar(hour: element, onRefresh: () { refreshDate(context); },),
//                                       )),
//                                     ],
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: master.theme(size).primaryColor),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                               ),
//                           Container(
//                             width: size.width * 0.5,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               child: Text('Visualizza Agenda'),
//                               style: ButtonStyle(
//                                 textStyle: MaterialStateProperty.all(
//                                     master.theme(size).textTheme.labelLarge),
//                                 backgroundColor: MaterialStateProperty.all(
//                                     master.theme(size).primaryColor),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )),
//               EtichettaCard(
//                   title: 'Agenda - ${DateTime.now().changeDateToString()}')
//             ],
//           )),
//     );
//   }
//
//   List<Hours> array_SelectionHour() {
//     var master = Provider.of<Master>(context, listen: false);
//
//     //Creo L'agenda
//     List<Hours> array_hours = createHours(minute: master.setting.hour);
//
//     //Determino in quale slot sono ora
//     var now_hour = detHours(minute: master.setting.hour);
//
//     //Estraggo tutti gli eventi di oggi
//     var array_event = master.array_event.where((element) => element.data_inizio.compare(DateTime.now(), TypeQuery.EQ));
//
//     //Mi estraggo tutte le ore già fissate
//     List<Hours> array_event_hours = [];
//     array_event.forEach((element) {array_event_hours.addAll(element.hours);});
//
//     //Associo lo slot con l'evento, se c'è
//     array_hours.forEach((element) {
//       var uidEVENT = array_event_hours.firstWhere((hour) => hour.number == element.number, orElse: Hours.standard).uidEVENT;
//       element.uidEVENT = uidEVENT;
//     });
//
//     array_hours.removeWhere((element) => element.number <= now_hour);
//
//     return array_hours;
//
//   }
//
//   void refreshDate(BuildContext context) {
//     var master = Provider.of<Master>(context, listen: false);
//     setState(() {
//       array_hour = array_SelectionHour();
//     });
//   }
// }
//
// class RowCalendar extends StatefulWidget {
//   RowCalendar({super.key, required this.hour, required this.onRefresh});
//
//   late Hours hour;
//   late Function() onRefresh;
//
//   @override
//   State<RowCalendar> createState() => _RowCalendarState();
// }
//
// class _RowCalendarState extends State<RowCalendar> {
//
//   late EVENT event = EVENT.standard();
//   late BUT000 user = BUT000.standard();
//
//
//   @override
//   Widget build(BuildContext context) {
//     var master = Provider.of<Master>(context, listen: false);
//     var size = MediaQuery.of(context).size;
//
//     var event = master.array_event.firstWhere(
//         (element) => element.uid == widget.hour.uidEVENT,
//         orElse: EVENT.standard);
//     var user = master.array_user.firstWhere(
//         (element) => element.uid == event.uidBUT000,
//         orElse: BUT000.standard);
//
//     return ElevatedButton(
//         onPressed: user.cf == ''
//             ? () {
//                 routeAddEvent();
//               }
//             : () {
//                 routeSelectUser(user);
//               },
//         child: Column(
//           children: [
//             if (user.uid != '') Text('${user.nome} ${user.cognome}'),
//             if (user.uid != '')
//               Text('${user.cf}',
//                   style: master.theme(size).textTheme.displaySmall),
//             if (user.uid == '') Text('Crea Appuntamento'),
//           ],
//         ));
//   }
//
//   void routeAddEvent() {
//     setState(() {
//       Navigator.pushNamed(context, SelectionView.Event.route,
//           arguments: RouteElement(SelectionView.Event.value, null)).then((value) => { widget.onRefresh()} );
//     });
//   }
//
//   void routeSelectUser(BUT000 element) {
//     Navigator.pushNamed(context, SelectionView.User.route,
//         arguments: RouteElement(SelectionView.User.value, element)).then((value) => { widget.onRefresh()} );
//   }
// }
