import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class RadioButtonCustom extends StatefulWidget {
  RadioButtonCustom({super.key, required this.text, this.select, required this.onChanged,});

  String text;
  bool? select;

  final ValueChanged<bool> onChanged;

  @override
  State<RadioButtonCustom> createState() => _RadioButtonCustomState();
}

class _RadioButtonCustomState extends State<RadioButtonCustom> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: master.childGrid(size),
      children: [
        Container(
          padding: EdgeInsets.only(left: 10.0),
          alignment: Alignment.centerLeft,
          child: Text(widget.text),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              value: true,
              groupValue: widget.select,
              onChanged: (value) {
                setState(() {
                  widget.select = value!;
                  widget.onChanged(value);
                });
              },
            ),
            Radio(
              value: false,
              groupValue: widget.select,
              onChanged: (value) {
                setState(() {
                  widget.select = value!;
                  widget.onChanged(value);
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
