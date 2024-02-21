import 'package:flutter/material.dart';

class TestExte extends StatefulWidget {
  TestExte({super.key, this.testo1, this.testo2});

  late String? testo1;
  late String? testo2;

  @override
  State<TestExte> createState() => _TestExteState();
}

class _TestExteState extends State<TestExte> {
  late String nome = "Pippo";
  late String cognome = "Paperino";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('Prova'),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.delete_forever_outlined)),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextProva2(context),
            ],
          )),
    );
  }
}

extension ProvaExt on _TestExteState {
  Widget TextProva2(BuildContext context) {
    var testo = widget.testo1;

    return Text('ProvaExt ${nome}');
  }

  void modifyNome() {
    nome = 'Pluto';
  }
}
