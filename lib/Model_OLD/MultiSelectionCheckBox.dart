import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class MultiSelectionCheckBox extends StatefulWidget {
  const MultiSelectionCheckBox({super.key});

  @override
  State<MultiSelectionCheckBox> createState() => _MultiSelectionCheckBoxState();
}

class _MultiSelectionCheckBoxState extends State<MultiSelectionCheckBox> {
  bool hourSelected = false;
  List<String> isTime = [];
  List<String> isTimeSelection = [];

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
        child: GridView.count(
      crossAxisCount: size_width > 500 ? 3 : 2,
      childAspectRatio: size_width > 500 ? 6 : 4.5,
      children: List<Widget>.generate(isTime.length, (index) {
        if (isTimeSelection!.contains(isTime[index])) {
          hourSelected = true;
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CheckboxListTile(
              activeColor: Colors.pink[300],
              dense: true,
              title: Text(isTime[index]),
              value: hourSelected,
              onChanged: (val) {
                setState(() {
                  if (!isTimeSelection!.contains(isTime[index])) {
                    if (isTimeSelection!.length < 3) {
                      isTimeSelection!.add(isTime[index]);
                      setState(() {});
                      print(isTimeSelection);
                    }
                  } else {
                    isTimeSelection!
                        .removeWhere((element) => element == isTime[index]);
                    setState(() {});
                    print(isTimeSelection);
                  }
                });
              }),
        );
      }),
    ));
  }
}
