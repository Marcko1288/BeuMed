import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class SingleSelectionItem extends StatefulWidget {
  const SingleSelectionItem({super.key});

  @override
  State<SingleSelectionItem> createState() => _SingleSelectionItemState();
}

class _SingleSelectionItemState extends State<SingleSelectionItem> {
  int hourSelected = 0;
  List<String> isTime = [];

  void selectTime(int timeSelected) {
    setState(() {
      hourSelected = timeSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GridView.count(
        crossAxisCount: size_width > 500 ? 3 : 2,
        childAspectRatio: size_width > 500 ? 6 : 4.5,
        children: List<Widget>.generate(
          isTime.length,
              (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  hourSelected = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: hourSelected == index
                        ? master.theme(size).primaryColor //.shade100
                        : null,
                    border: Border.all(
                        color: master.theme(size).primaryColor),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      focusColor: Colors.white,
                      groupValue: hourSelected,
                      onChanged: (timeSelected) {
                        setState(() {
                          hourSelected = timeSelected!;
                          //hour = isTime[timeSelected];
                        });
                      },
                      value: index,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 10, right: 20),
                      child: Text(
                        isTime[index],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}