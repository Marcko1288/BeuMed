import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Class/Model/Enum_StatoCivile.dart';
import 'package:beumed/Class/Model/Enum_TypeDecoration.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:beumed/Model/RadioButton.dart';
import 'package:beumed/View/Det_User/BoxContatti.dart';
import 'package:beumed/View/Det_User/Box_Indirizzo.dart';
import 'package:beumed/View/Det_User/FireDet_User.dart';
import 'package:beumed/View/Det_User/FuctionDetUser.dart';
import 'package:beumed/View/Det_User/WidgetDetUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beumed/Class/Master.dart';
import 'package:beumed/Class/Model/Enum_TypeState.dart';
import 'package:beumed/Class/BUT000.dart';
import 'package:beumed/Library/FireAuth.dart';
import 'package:beumed/Library/FireStore.dart';
import 'package:beumed/Model/TextFieldCustom.dart';
import '../Det_User/Block_Anagrafico.dart';

class Det_UserView extends StatefulWidget {
  Det_UserView({super.key, this.state = TypeState.read, this.user});

  late BUT000? user;
  late TypeState state;

  @override
  State<Det_UserView> createState() => Det_UserViewState();
}

class Det_UserViewState extends State<Det_UserView> {
  late String nome = "";
  late String cognome = "";

  late String cf = "";
  late String piva = "";
  late DateTime birthday = DateTime.now();
  late String local_birthday = "";

  late String indirizzo = "";
  late String citta = "";
  late String cap = "";
  late String provincia = "";

  late String mail = "";
  late String phone = "";
  late String mobile_phone = "";

  late SelectionStatoCivile stato_civile = SelectionStatoCivile.S1;

  Map<String, dynamic?> anamnesi = {
    'Vaccinazione antitetanica' : null,
    'Fuma?' : null,
    'Beve alcolici? (vino, birra, superalcolici…)' : null,
    'Allergie' : null,
    'Altre malattie respiratorie' : null,
    'Anemia' : null,
    'Svenimenti' : null,
    'Palpitazioni' : null,
    'Vertigini' : null,
    'Pressione elevata' : null,
   'Colesterolo elevato' : null,
    'Malattie del fegato/vie biliari' : null,
    'Malattie neurologiche' : null,
    'Neoplasie' : null,
    'Malattie dei reni/vie urinarie' : null,
    'Asma bronchiale' : null,
    'Otiti/sinusiti' : null,
    'Epilessia' : null,
    'Malattie di cuore' : null,
    'Dolore toracico' : null,
    'Disturbi visivi' : null,
    'Diabete mellito' : null,
    'Malattie gastro-intestinali' : null,
    'Malattie muscolo-scheletriche' : null,
    'Malattie tiroidee' : null,
    'Malattie psichiatriche' : null,
    'Altro' : null,
  };
  late String other = "";

  late SelectionProfile profilo = SelectionProfile.paziente;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size_width = MediaQuery.of(context).size.width;
    var size_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Title_AppBar(context),
        ),
        actions: [
          if (widget.state != TypeState.insert)
            IconButton(
                onPressed: deleteElement,
                icon: Icon(Icons.delete_forever_outlined)),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFiscalDate(context),
                  TextAddress(context),
                  TextContact(context),
                  TextAnamnesia(context),
                ],
              )),
        ),
      ),
      floatingActionButton: action_button(context),
    );
  }

  Widget TextAnamnesia(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InputDecorator(
        decoration: TypeDecoration.labolBord.value(context, "Anamnesi"),
        child: Column(
          children: [
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: master.childGrid(size),
                children: [
                  Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('SI'), Text('NO')],
                  ),
                ]
            ),
            Column(
              children: anamnesi.entries.map((element) {
                return RadioButtonCustom(
                  text: element.key,
                  select: element.value,
                  onChanged: (value){
                    anamnesi[element.key] = value;
                  }
              );
              }).toList(),
            ),
          ],
        )
      ),
    );
  }
}


