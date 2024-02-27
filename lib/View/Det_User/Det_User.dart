import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Class/Model/Enum_StatoCivile.dart';
import 'package:beumed/Class/Model/Enum_TypeDecoration.dart';
import 'package:beumed/Library/Extension_Date.dart';
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
import '../../Library/Enum_TypeFormatDate.dart';
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

  bool open_boxanamnesi = false;
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
  };
  late String other = "";

  bool open_boxnote = false;
  Map<DateTime, String> note = {};
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
                  TextNote(context),
                  Container(
                    height: size_height * 0.1,
                  )
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(), // Assicurati che Container abbia una dimensione definita
                IconButton(
                  onPressed: () {
                    setState(() {
                      open_boxanamnesi = !open_boxanamnesi;
                    });
                  },
                  icon: open_boxanamnesi ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.keyboard_arrow_up),
                  ) : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ],
            ),
            if (open_boxanamnesi)
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: master.childGrid(size),
                children: [
                  Container(), // Assicurati che il contenuto del GridView.count abbia un'implementazione corretta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Text('SI'), Text('NO')],
                  ),
                ],
              ),
            if (open_boxanamnesi)
              Column(
                children: anamnesi.entries.map((element) {
                  return RadioButtonCustom(
                    text: element.key,
                    select: element.value,
                    enabled: widget.state == TypeState.read ? false : true,
                    onChanged: (value) {
                      setState(() {
                        anamnesi[element.key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
            if (open_boxanamnesi)
              TextFormField(
                initialValue: other,
                enabled: widget.state == TypeState.read ? false : true,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: "Altro",
                  focusedBorder: defaultBorder(master.theme(size).primaryColor),
                  enabledBorder: defaultBorder(master.theme(size).primaryColor),
                  disabledBorder: defaultBorder(master.theme(size).primaryColor),
                ),
                onChanged: (String value) {
                  setState(() {
                    other = value;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget TextNote(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    bool open_note = false;
    int length_note = 10;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InputDecorator(
        decoration: TypeDecoration.labolBord.value(context, "Note"),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: widget.state == TypeState.read ? null : () {
                  setState(() {
                    print('new_note: ${new_note}');
                    if (new_note == false) {
                      new_note = true;
                      note[DateTime.now()] = '';
                      print('new_note: ${new_note}');
                    }
                  });
                },
                icon: Icon(Icons.add_circle_outline),
              ),
            ),
            Column(
              children: note.entries.map((element) {
                String title = element.key.changeDateToString(type: TypeFormatDate.DD_MM_AAAA_HH_MM);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded( // Aggiunto Expanded per far sì che il TextFormField occupi lo spazio disponibile
                        child: TextFormField(
                          initialValue: element.value,
                          enabled: widget.state == TypeState.read ? false : true,
                          maxLines: length_note, // Corretto il nome della variabile 'length_note'
                          decoration: InputDecoration(
                            labelText: title,
                            focusedBorder: defaultBorder(master.theme(size).primaryColor),
                            enabledBorder: defaultBorder(master.theme(size).primaryColor),
                            disabledBorder: defaultBorder(master.theme(size).primaryColor),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              note[element.key] = value;
                            });
                          },
                        ),
                      ),
                      if (widget.state != TypeState.insert)
                        IconButton(
                          onPressed: widget.state == TypeState.read ? null : () {
                            setState(() {
                              open_note = !open_note;
                              length_note = open_note ? 10 : 1;
                            });
                          },
                          icon: open_note ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}


