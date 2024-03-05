import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/BUT000.dart';
import '../Model/EtichettaCard.dart';
import '../Model/RowDetail.dart';


class Box extends StatefulWidget {
  Box({super.key, required this.title_card, required this.array, required this.onPressed, required this.onRefresh});

  String title_card;
  List<BUT000> array;
  late Function() onPressed;
  late Function() onRefresh;

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  @override
  Widget build(BuildContext context) {

    var master = Provider.of<Master>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: Card(
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20) ),
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for(var element in widget.array)
                          ElevatedButton(
                            onPressed: () { routeDettaglio(); }, //() => { /* DA COMPLETARE */ },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                foregroundColor: MaterialStateProperty.all(Colors.black),
                                elevation:  MaterialStateProperty.all(0),
                                overlayColor:  MaterialStateProperty.all(Colors.grey[200]),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.transparent)
                                    )
                                )
                            ),
                            child: RowDetail(
                                title:
                                '${element.nome} ${element.cognome}',
                                body:
                                'Appuntamento: 12/01/2024 12:30 \nCF: ${element.cf} \n@: ${element.mail}',
                                iconrow: Icons.connected_tv_outlined
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: widget.onPressed, //() => { /* DA COMPLETARE */ },
                            child: Text('Dettagli'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all( EdgeInsets.only(left: 80, right: 80, top: 20, bottom: 20) ),
                              shape: MaterialStateProperty.all( RoundedRectangleBorder(  borderRadius: BorderRadius.circular(20) ) ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
              EtichettaCard(title: widget.title_card )
            ],
          )
      ),
    );
  }

  void routeDettaglio(){
    //Navigator.pushNamed(context, SelectionView.SubContract_Dettaglio.route, arguments: RouteElement(SelectionView.SubContract_Dettaglio.value, element)).then((value) {widget.onRefresh();});
  }
}
