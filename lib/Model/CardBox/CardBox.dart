import 'package:flutter/material.dart';

import 'EtichettaCard.dart';

class CardBox extends StatefulWidget {
  CardBox({super.key, required this.text_card, required this.child});

  final Widget child;
  final String text_card;

  @override
  State<CardBox> createState() => _CardBoxState();
}

class _CardBoxState extends State<CardBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: widget.child,
                    ),
                  )),
              EtichettaCard(
                  title: widget.text_card
              )
            ],
          )
      ),
    );
  }
}
