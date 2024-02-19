import 'package:beumed/Library/Enum_TypeDate.dart';
import 'package:beumed/Library/Enum_TypeFormatDate.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:beumed/Model/TextFieldCustom.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Class/Master.dart';
// import '../View/Det_Event.dart';

// class DatePickerNew extends StatefulWidget {
//   DatePickerNew(
//       {super.key,
//       this.restorationId,
//       required this.selection_date,
//       required this.min_year,
//       required this.max_year,
//       bool? check_date,
//       List<String>? array_nodate,
//       this.modify = true,
//       required this.onDateTimeChanged})
//       : this.array_nodate = array_nodate ?? [],
//         this.check_date = check_date ?? true;

//   final ValueChanged<DateTime> onDateTimeChanged;

//   final String? restorationId;
//   DateTime selection_date;
//   int min_year;
//   int max_year;
//   bool check_date;
//   List<String> array_nodate;

//   bool modify;

//   @override
//   State<DatePickerNew> createState() => _DatePickerNewState();
// }

// class _DatePickerNewState extends State<DatePickerNew> with RestorationMixin {
//   @override
//   String? get restorationId => widget.restorationId;
//   late DateTime select_date = widget.selection_date;

//   late RestorableDateTime _selectedDate =
//       RestorableDateTime(select_date); //widget.selection_date);
//   late int _min_year = widget.min_year;
//   late int _max_year = widget.max_year + 1;
//   late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//       RestorableRouteFuture<DateTime?>(
//     onComplete: _selectDate,
//     onPresent: (NavigatorState navigator, Object? arguments) {
//       return navigator.restorablePush(
//         _datePickerRoute,
//         arguments: _selectedDate.value.millisecondsSinceEpoch,
//       );
//     },
//   );

//   @pragma('vm:entry-point')
//   Route<DateTime> _datePickerRoute(
//     BuildContext context,
//     Object? arguments,
//   ) {
//     return DialogRoute<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         int firstDate = _min_year; //_selectedDate.value.year - 5;
//         int lastDate = _max_year; //_selectedDate.value.year + 1;

//         return DatePickerDialog(
//           restorationId: 'date_picker_dialog',
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
//           firstDate: DateTime(firstDate),
//           lastDate: DateTime(lastDate),
//           selectableDayPredicate: (selectDate) {
//             if (widget.check_date) {
//               if (widget.array_nodate.isEmpty)
//                 array_holiday.addAll(widget.array_nodate);
//               if (selectDate.weekday == 6 ||
//                   selectDate.weekday == 7 ||
//                   array_holiday.contains(selectDate.changeDateToString()) ||
//                   widget.array_nodate
//                       .contains(selectDate.changeDateToString())) {
//                 return false;
//               } else {
//                 return true;
//               }
//             }
//             return true;
//           },
//         );
//       },
//     );
//   }

//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_selectedDate, 'selected_date');
//     registerForRestoration(
//         _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   }

//   void _selectDate(DateTime? newSelectedDate) {
//     if (newSelectedDate != null) {
//       setState(() {
//         _selectedDate.value = newSelectedDate;
//         widget.onDateTimeChanged(newSelectedDate);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var master = Provider.of<Master>(context, listen: false);
//     var size = MediaQuery.of(context).size;
//     return Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: ElevatedButton(
//             onPressed: widget.modify
//                 ? () {
//                     _restorableDatePickerRouteFuture.present();
//                   }
//                 : null,
//             style: ButtonStyle(
//               overlayColor: null,
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//             child: Container(
//               width: double.infinity,
//               alignment: Alignment.center,
//               child: TextFormField(
//                 initialValue:
//                     "${_selectedDate.value.changeDateToString(type: TypeFormatDate.DD_MM_AAAA)}",
//                 decoration: InputDecoration(
//                   labelText: "Data di Nascita",
//                   focusedBorder: defaultBorder(master.theme(size).primaryColor),
//                   enabledBorder: defaultBorder(master.theme(size).primaryColor),
//                   disabledBorder:
//                       defaultBorder(master.theme(size).primaryColor),
//                 ),
//                 //enabled: false,
//               ),
//             )));

//     //   Padding(
//     //   padding: const EdgeInsets.only(top: 10, bottom: 10),
//     //   child: OutlinedButton(
//     //     style: OutlinedButton.styleFrom(
//     //         side: BorderSide(color: master.theme(size).primaryColor),
//     //         shape: RoundedRectangleBorder(
//     //             borderRadius: BorderRadius.circular(20))),
//     //     onPressed: widget.modify
//     //         ? () {
//     //             _restorableDatePickerRouteFuture.present();
//     //           }
//     //         : null,
//     //     child: Container(
//     //       width: double.infinity,
//     //       alignment: Alignment.center,
//     //       child: Text(
//     //         "${_selectedDate.value.changeDateToString(type: TypeFormatDate.DD_MM_AAAA)}",
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class DatePickerNew extends StatefulWidget {
  DatePickerNew({
    Key? key,
    required this.date,
    required this.onDateChanged,
    this.enabled = true,
    this.decoration = TypeDecoration.labolBord,
  }) : super(key: key);

  final DateTime date;
  final ValueChanged<DateTime> onDateChanged;
  final bool enabled;
  final TypeDecoration decoration;

  @override
  State<DatePickerNew> createState() => _DatePickerNewState();
}

class _DatePickerNewState extends State<DatePickerNew> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: widget.enabled ? _selectDate : null,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Data di Nascita',
            labelStyle:
                TextStyle(color: master.theme(size).colorScheme.primary),
            border: defaultBorderDate(master.theme(size).primaryColor),
            focusedBorder: defaultBorder(master.theme(size).primaryColor),
            enabledBorder: defaultBorder(master.theme(size).primaryColor),
            disabledBorder: defaultBorder(master.theme(size).primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${_selectedDate.changeDateToString(type: TypeFormatDate.DD_MM_AAAA)}",
                //style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.onDateChanged(_selectedDate);
      });
    }
  }
}

OutlineInputBorder defaultBorderDate(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: color),
  );
}
