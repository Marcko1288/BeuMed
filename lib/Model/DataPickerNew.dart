import 'package:beumed/Class/Model/Enum_TypeDecoration.dart';
import 'package:beumed/Library/Enum_TypeDate.dart';
import 'package:beumed/Library/Enum_TypeFormatDate.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:beumed/Model/TextFieldCustom.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class DatePickerNew extends StatefulWidget {
  DatePickerNew({
    Key? key,
    required this.date,
    required this.onDateChanged,
    this.text_labol = '',
    this.enabled = true,
    this.decoration = TypeDecoration.labolBord,
  }) : super(key: key);

  final DateTime date;

  ///Data Selezionata
  final String text_labol;

  ///Testo da mostrare sul bordo del campo
  final bool enabled;

  ///Attiva/Disattiva la DataPicker
  final TypeDecoration decoration;

  ///Determina Decorazione Bordi
  final ValueChanged<DateTime> onDateChanged;

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: widget.enabled ? _selectDate : null,
        child: InputDecorator(
          decoration: widget.decoration.value(context, widget.text_labol),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${_selectedDate.changeDateToString(type: TypeFormatDate.DD_MM_AAAA)}",
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
