import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class MultiRadioButton extends StatefulWidget {
  MultiRadioButton({
    super.key,
    required this.index,
    required this.text,
    this.enable = true,
    required this.onTap
  });

  late int index;
  late String text;
  late bool enable;

  final GestureTapCallback onTap;

  @override
  State<MultiRadioButton> createState() => _MultiRadioButtonState();
}

class _MultiRadioButtonState extends State<MultiRadioButton> {

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(children: [
        InkWell(
          onTap: widget.enable ? () {
            setState(() {
              widget.onTap();
            });
          } : null,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.index == 1
                    ? master.theme(size).primaryColorLight //.shade100
                    : null,
                border:
                Border.all(color: master.theme(size).primaryColor),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  focusColor: Colors.white,
                  groupValue: widget.index,
                  onChanged: null,
                  value: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Text(widget.text),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
