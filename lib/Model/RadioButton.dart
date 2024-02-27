import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class RadioButtonCustom extends StatefulWidget {
  RadioButtonCustom({super.key, required this.text, this.select, this.enabled = true, required this.onChanged,});

  String text;
  bool? select;
  bool enabled;

  final ValueChanged<bool?> onChanged;

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
              onChanged: widget.enabled ? (value) {
                setState(() {
                  bool new_value = value as bool;
                  widget.select = new_value;
                  widget.onChanged(new_value);
                });
              } : null,
            ),
            Radio(
              value: false,
              groupValue: widget.select,
              onChanged: widget.enabled ? (value) {
                setState(() {
                  bool new_value = value as bool;
                  widget.select = new_value;
                  widget.onChanged(new_value);
                });
              } : null,
            ),
          ],
        )
      ],
    );
  }
}
