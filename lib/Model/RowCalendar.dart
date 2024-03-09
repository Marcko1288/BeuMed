import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class RowCalendar extends StatefulWidget {
  RowCalendar({super.key, required this.title_text, this.body_text});

  late String title_text;
  late String? body_text;

  @override
  State<RowCalendar> createState() => _RowCalendarState();
}

class _RowCalendarState extends State<RowCalendar> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Text(widget.title_text),
        if(widget.body_text != null)
          Text(widget.body_text.toString(),
              style: master.theme(size).textTheme.displaySmall),
      ],
    );
  }
}
