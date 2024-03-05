import 'package:beumed/Model/MultiRadioButton.dart';
import 'package:beumed/View/Det_Event/0.Det_Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Class/Model/Enum_TypeState.dart';

extension BoxSelectHours on Det_EventViewState {
  //Seleziona Hour
  Widget SelectHour(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: size.width > 1000 ? 3 : 1,
          childAspectRatio: master.childGrid(size),
          children: List<Widget>.generate(isTime.length, (index) {
            var state = widget.state == TypeState.read ? false : isTime[index].uidEVENT == '' ? true : false;
            var indexSelect = isTimeSelection!.contains(isTime[index]) ? 1 : 0;
            // var indexSelect = isTimeSelection.indexWhere((element) => element.number == isTime[index].number ) >= 0 ? 1 : 0;
            return MultiRadioButton(
                index: indexSelect,
                text: isTime[index].nome,
                enable: state,
                onTap: () {
                  setState(() {
                    if (!isTimeSelection!.contains(isTime[index])) {
                      if (isTimeSelection!.length < 3) {
                        isTimeSelection!.add(isTime[index]);
                        indexSelect = 1;
                      } else {
                        master.gestion_Message(
                            'Non è possibile selezionare più di tre slot');
                      }
                    } else {
                      isTimeSelection!
                          .removeWhere((element) => element == isTime[index]);
                      indexSelect = 0;
                    }
                  });
                }
            );
            //   Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Stack(children: [
            //     InkWell(
            //       onTap: widget.state == TypeState.read
            //           ? null
            //           : () {
            //               setState(() {
            //                 if (!isTimeSelection!.contains(isTime[index])) {
            //                   if (isTimeSelection!.length < 3) {
            //                     isTimeSelection!.add(isTime[index]);
            //                     indexSelect = 1;
            //                   } else {
            //                     master.gestion_Message(
            //                         'Non è possibile selezionare più di tre slot');
            //                   }
            //                 } else {
            //                   isTimeSelection!.removeWhere(
            //                       (element) => element == isTime[index]);
            //                   indexSelect = 0;
            //                   setState(() {});
            //                 }
            //               });
            //             },
            //       child: Container(
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //             color: indexSelect == 1
            //                 ? master.theme(size).primaryColorLight //.shade100
            //                 : null,
            //             border:
            //                 Border.all(color: master.theme(size).primaryColor),
            //             borderRadius: BorderRadius.circular(20)),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Radio(
            //               focusColor: Colors.white,
            //               groupValue: indexSelect,
            //               onChanged: null,
            //               value: 1,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.only(left: 10, right: 20),
            //               child: Text(
            //                 isTime[index].nome,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ]),
            // );
          })),
    );
  }
}
