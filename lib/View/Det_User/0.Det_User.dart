import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Class/Model/Enum_StatoCivile.dart';
import 'package:beumed/Class/Model/Enum_TypeDecoration.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:beumed/Model/RadioButton.dart';
import 'package:beumed/View/Det_User/1.4.BoxContatti.dart';
import 'package:beumed/View/Det_User/1.5.Box_Anamnesi.dart';
import 'package:beumed/View/Det_User/1.3.Box_Indirizzo.dart';
import 'package:beumed/View/Det_User/1.6.Box_Note.dart';
import 'package:beumed/View/Det_User/3.Fire_Det_User.dart';
import 'package:beumed/View/Det_User/2.Fuction_Det_User.dart';
import 'package:beumed/View/Det_User/1.1.Widget_Det_User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:beumed/Class/Master.dart';
import 'package:beumed/Class/Model/Enum_TypeState.dart';
import 'package:beumed/Class/BUT000.dart';
import '../Det_User/1.2.Box_Anagrafico.dart';

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

  bool open_boxanamnesi = false;
  List<Anamnesi> anamnesi = [];
  late String other = "";

  List<Note> note = [];
  bool new_note = false;

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
    var size = MediaQuery.of(context).size;

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
                  TextNote(context),
                  Container(
                    height: size.height * 0.1,
                  )
                ],
              )),
        ),
      ),
      floatingActionButton: action_button(context),
    );
  }
}
