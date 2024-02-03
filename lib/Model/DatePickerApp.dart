import 'package:beumed/Library/Enum_TypeDate.dart';
import 'package:beumed/Library/Enum_TypeFormatDate.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class DatePickerCustom extends StatefulWidget {
  DatePickerCustom(
      {super.key,
      this.restorationId,
      required this.selection_date,
      required this.min_year,
      required this.max_year,
      List<String>? array_nodate,
      this.modify = true,
      required this.onDateTimeChanged})
      : this.array_nodate = array_nodate ?? [];

  final ValueChanged<DateTime> onDateTimeChanged;

  final String? restorationId;
  DateTime selection_date;
  int min_year;
  int max_year;
  List<String> array_nodate;

  bool modify;

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  late DateTime select_date = detSelectionDate();

  late RestorableDateTime _selectedDate =
      RestorableDateTime(select_date); //widget.selection_date);
  late int _min_year = widget.min_year;
  late int _max_year = widget.max_year + 1;
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        int firstDate = _min_year; //_selectedDate.value.year - 5;
        int lastDate = _max_year; //_selectedDate.value.year + 1;

        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(firstDate),
          lastDate: DateTime(lastDate),
          selectableDayPredicate: (selectDate) {
            if (widget.array_nodate.isEmpty) array_no_date.addAll(widget.array_nodate);
            if (selectDate.weekday == 6 ||
                selectDate.weekday == 7 ||
                array_no_date.contains(selectDate.changeDateToString()) ||
                widget.array_nodate.contains(selectDate.changeDateToString())) {
              return false;
            } else {
              return true;
            }
          },
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.onDateTimeChanged(newSelectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double size_text = defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android
        ? 20.0
        : 50.0;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            // padding: EdgeInsets.only(
            //   left: size_text, right: size_text, top: 20, bottom: 20),
            backgroundColor: master.theme(size).primaryColor, //.shade100,
            side: BorderSide(color: master.theme(size).primaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        onPressed: widget.modify
            ? () {
                _restorableDatePickerRouteFuture.present();
              }
            : null,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            "${_selectedDate.value.changeDateToString(type: TypeFormatDate.DD_MM_AAAA)}",
            //style: master.theme(size).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  DateTime detSelectionDate(){
    print('detSelectionDate');
    var array_noDate = array_no_date;
    array_noDate.addAll(widget.array_nodate);
    var date_output = widget.selection_date;
    array_noDate.sort((a,b) => a.compareTo(b));

    if (date_output.weekday == 6) date_output = date_output.add(Duration(days: 2));
    if (date_output.weekday == 7) date_output = date_output.add(Duration(days: 1));

    for(var element in array_noDate){
      if (element.changeStringToDate().year > date_output.year) break;
      if (element == date_output.changeDateToString()) date_output.add(Duration(days: 1));
    }
    return date_output;
  }
}

List<String> array_no_date = [
  '31/03/2024',
  '20/04/2025',
  '05/04/2026',
  '28/03/2027',
  '16/04/2028',
  '01/04/2029',
  '21/04/2030',
  '13/04/2031',
  '28/03/2032',
  '17/04/2033',
  '09/04/2034',
  '25/03/2035',
  '13/04/2036',
  '05/04/2037',
  '25/04/2038',
  '10/04/2039',
  '01/04/2040',
  '21/04/2041',
  '06/04/2042',
  '29/03/2043',
  '17/04/2044',
  '09/04/2045',
  '25/03/2046',
  '14/04/2047',
  '05/04/2048',
  '18/04/2049',
  '10/04/2050',
  '01/04/2024',
  '21/04/2025',
  '06/04/2026',
  '29/03/2027',
  '17/04/2028',
  '02/04/2029',
  '22/04/2030',
  '14/04/2031',
  '29/03/2032',
  '18/04/2033',
  '10/04/2034',
  '26/03/2035',
  '14/04/2036',
  '06/04/2037',
  '26/04/2038',
  '11/04/2039',
  '02/04/2040',
  '22/04/2041',
  '07/04/2042',
  '30/03/2043',
  '18/04/2044',
  '10/04/2045',
  '26/03/2046',
  '15/04/2047',
  '06/04/2048',
  '19/04/2049',
  '11/04/2050',
  for (int i = 2024; i <= 2050; i++) '01/01/${i}',
  for (int i = 2024; i <= 2050; i++) '06/01/${i}',
  for (int i = 2024; i <= 2050; i++) '25/04/${i}',
  for (int i = 2024; i <= 2050; i++) '01/05/${i}',
  for (int i = 2024; i <= 2050; i++) '02/06/${i}',
  for (int i = 2024; i <= 2050; i++) '15/08/${i}',
  for (int i = 2024; i <= 2050; i++) '01/11/${i}',
  for (int i = 2024; i <= 2050; i++) '08/12/${i}',
  for (int i = 2024; i <= 2050; i++) '25/12/${i}',
  for (int i = 2024; i <= 2050; i++) '26/12/${i}',
];
