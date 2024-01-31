import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';

class EtichettaCard extends StatefulWidget {
  EtichettaCard({super.key, required this.title});

  String title;

  @override
  State<EtichettaCard> createState() => _EtichettaCardState();
}

class _EtichettaCardState extends State<EtichettaCard> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            color: ThemeData().primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ) // green shaped
        ),
        child: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
