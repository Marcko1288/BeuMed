import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Class/Model/Enum_StatoCivile.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/Model/Enum_TypeState.dart';
import '../Class/BUT000.dart';
import '../Library/FireAuth.dart';
import '../Library/FireStore.dart';
import '../Model/DatePickerApp.dart';
import '../Model/TextFieldCustom.dart';

class Det_UserView extends StatefulWidget {
  Det_UserView({super.key, this.state = TypeState.read, this.user});

  late BUT000? user;
  late TypeState state;

  @override
  State<Det_UserView> createState() => _Det_UserViewState();
}

class _Det_UserViewState extends State<Det_UserView> {
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

  late bool? type_1;
  late bool? type_2;
  late bool? type_3;
  late bool? type_4;
  late bool? type_5;
  late bool? type_6;
  late bool? type_7;
  late bool? type_8;
  late bool? type_9;
  late bool? type_10;
  late bool? type_11;
  late bool? type_12;
  late String? type_13;

  late SelectionProfile profilo = SelectionProfile.paziente;

  final _formKey = GlobalKey<FormState>();

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
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFiscalDate(context),
                TextAddress(context),
                TextContact(context),
              ],
            )),
      ),
      floatingActionButton: action_button(context),
    );
  }

  Widget Title_AppBar(BuildContext context) {
    switch (widget.state) {
      case TypeState.read:
        return Text("Appuntamento");
      case TypeState.insert:
        return Text("Nuovo Appuntamento");
      case TypeState.modify:
        return Text("Modifica Appuntamento");
    }
  }

  String Title_Button() {
    switch (widget.state) {
      case TypeState.read:
        return 'Modifica Paziente';
      case TypeState.insert:
        return 'Salva Paziente';
      case TypeState.modify:
        return 'Salva Paziente';
    }
  }

  Widget action_button(BuildContext contextT) {
    return FloatingActionButton(
      onPressed: () {
        actionElement();
      },
      tooltip: Title_Button(),
      child: widget.state == TypeState.read
          ? Icon(Icons.mode_edit_outline_outlined)
          : Icon(Icons.save_as_outlined),
    );
  }

  Widget TextFiscalDate(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
        child: GridView.count(
            crossAxisCount: size_width > 500 ? 3 : 2,
            childAspectRatio: size_width > 500 ? 6 : 4.5,
            children: [
          TextFieldCustom(
            text_labol: "Nome",
            text_default: nome,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              nome = value;
            },
            listValidator: [
              TypeValidator.required,
            ],
          ),
          TextFieldCustom(
              text_labol: 'Cognome',
              text_default: cognome,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                cognome = value;
              },
              listValidator: [
                TypeValidator.required,
              ]),
          TextFieldCustom(
              text_labol: 'Codice Fiscale',
              text_default: cf,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                cf = value;
              },
              listValidator: [TypeValidator.required, TypeValidator.cf]),
          TextFieldCustom(
              text_labol: 'Partita Iva',
              text_default: piva,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                piva = value;
              },
              listValidator: [TypeValidator.required, TypeValidator.piva]),
          DatePickerCustom(
            selection_date: birthday,
            min_year: DateTime.now().subtract(Duration(days: 365 * 80)).year,
            max_year: DateTime.now().year,
            check_date: false,
            modify: widget.state == TypeState.read ? false : true,
            onDateTimeChanged: (DateTime value) {
              setState(() {
                birthday = value;
              });
            },
          ),
          TextFieldCustom(
            text_labol: 'Luogo di Nascita',
            text_default: local_birthday,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              local_birthday = value;
            },
          ),
          DropdownSearch<SelectionStatoCivile>(
            enabled: widget.state == TypeState.read ? false : true,
            items: SelectionStatoCivile.arrayElement(),
            itemAsString: (SelectionStatoCivile element) => element.name,
            dropdownButtonProps:
                DropdownButtonProps(color: master.theme(size).primaryColor),
            dropdownDecoratorProps: DropDownDecoratorProps(
              //Bottone
              baseStyle: master
                  .theme(size)
                  .textTheme
                  .bodyMedium, //Testo mostrato nel campo
              textAlignVertical: TextAlignVertical.center,
              dropdownSearchDecoration: InputDecoration(
                enabledBorder: defaultBorder(master.theme(size).primaryColor),
                focusedBorder: defaultBorder(master.theme(size).primaryColor),
                errorBorder: defaultBorder(master.theme(size).primaryColor),
                disabledBorder: defaultBorder(master.theme(size).primaryColor),
                focusedErrorBorder:
                    defaultBorder(master.theme(size).primaryColor),
              ),
            ),
            onChanged: (value) {
              setState(() {
                stato_civile = value!;
              });
            },
            selectedItem: stato_civile,
          ),
        ])
    );
  }

  Widget TextAddress(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
        child: GridView.count(
            crossAxisCount: size_width > 500 ? 3 : 2,
            childAspectRatio: size_width > 500 ? 6 : 4.5,
            children: [
          TextFieldCustom(
            text_labol: 'Indirizzo',
            text_default: indirizzo,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              indirizzo = value;
            },
          ),
          TextFieldCustom(
            text_labol: 'CAP',
            text_default: cap,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            limit_char: 5,
            onStringChanged: (String value) {
              cap = value;
            },
          ),
          TextFieldCustom(
            text_labol: 'Città',
            text_default: citta,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              citta = value;
            },
          ),
          TextFieldCustom(
            text_labol: 'Provincia',
            text_default: provincia,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            limit_char: 2,
            onStringChanged: (String value) {
              provincia = value;
            },
          ),
        ]));
  }

  Widget TextContact(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
        child: GridView.count(
      crossAxisCount: size_width > 500 ? 3 : 2,
      childAspectRatio: size_width > 500 ? 6 : 4.5,
      children: [
        TextFieldCustom(
            text_labol: 'Mail',
            text_default: mail,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              mail = value;
            },
            listValidator: [TypeValidator.required, TypeValidator.email]),
        TextFieldCustom(
            text_labol: 'Telefono Fisso',
            text_default: phone,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              phone = value;
            },
            listValidator: [TypeValidator.number]),
        TextFieldCustom(
            text_labol: 'Cellulare',
            text_default: mobile_phone,
            enabled: widget.state == TypeState.read ? false : true,
            decoration: TypeDecoration.labolBord,
            onStringChanged: (String value) {
              mobile_phone = value;
            },
            listValidator: [TypeValidator.number]),
      ],
    ));
  }

  void refreshDate() {
    setState(() {
      if (widget.state == TypeState.insert) {
        mail = '';
        cf = '';
        nome = '';
        cognome = '';
        profilo = SelectionProfile.paziente;
        indirizzo = '';
        citta = '';
        cap = '';
        provincia = '';
      } else {
        mail = widget.user!.mail;
        cf = widget.user!.cf;
        nome = widget.user!.nome;
        cognome = widget.user!.cognome;
        profilo = widget.user!.profilo;
        indirizzo = widget.user!.indirizzo;
        citta = widget.user!.citta;
        cap = widget.user!.cap.toString();
        provincia = widget.user!.provincia;
      }
    });
  }

  Future<void> actionElement() async {
    var master = Provider.of<Master>(context, listen: false);

    print('widget.state: ${widget.state}');
    if (_formKey.currentState!.validate()) {
      if (widget.state == TypeState.read) {
        setState(() {
          widget.state = TypeState.modify;
        });
      } else {
        if (widget.state == TypeState.insert) {
          if (widget.user == null) {
            await insertElement();
          } else {
            await modifyElement();
          }
        }
        if (widget.state == TypeState.modify) {
          await modifyElement();
        }
      }
    }
  }

  Future<void> insertElement() async {
    var master = Provider.of<Master>(context, listen: false);
    bool insert = true;

    var result_data = master.array_user.where((e) => e.cf == cf);
    if (result_data.isNotEmpty) {
      insert == false;
      setState(() {
        master.gestion_Message('Utente già registrato!');
        return;
      });
    }

    if (insert == true) {
      var user = BUT000(
          mail: mail,
          cf: cf,
          nome: nome,
          cognome: cognome,
          piva: piva,
          indirizzo: indirizzo,
          citta: citta,
          cap: cap.changeStringToInt(),
          provincia: provincia,
          uidBUT000: master.user.uid);

      try {
        var dirDB = FireStore()
            .dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
        var element_map = user.toDB();
        await FireStore().insertFirestore(patch: dirDB, map: element_map);
        print('Caricamento OK');
        widget.user = user;
        master.array_user.add(user);

        setState(() {
          master.gestion_Message('Dati caricati correttamente');
          widget.state = TypeState.read;
          refreshDate();
          return;
        });
        return;
      } on FirebaseException catch (error) {
        print('${error.toString()}');
        setState(() {
          master.gestion_Message(
              'Errore caricamento nel DB, ${error.toString()}');
          return;
        });
        return;
      }
    }
  }

  Future<void> modifyElement() async {
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_user
        .indexWhere((element) => element.uid == widget.user!.uid);
    master.array_user[index].mail = mail;
    master.array_user[index].cf = cf;
    master.array_user[index].nome = nome;
    master.array_user[index].cognome = cognome;
    master.array_user[index].piva = piva;
    master.array_user[index].indirizzo = indirizzo;
    master.array_user[index].citta = citta;
    master.array_user[index].cap = cap.changeStringToInt();
    master.array_user[index].provincia = provincia;

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
      var element_map = master.array_user[index].toDB();
      await FireStore().modifyFireStore(patch: dirDB, map: element_map);
      print('Modifica OK');

      setState(() {
        master.gestion_Message('Dati modificati correttamente');
        widget.state = TypeState.read;
        refreshDate();
        return;
      });
      return;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master
            .gestion_Message('Errore caricamento nel DB, ${error.toString()}');
        return;
      });
      return;
    }
  }

  Future<void> deleteElement() async {
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_user
        .indexWhere((element) => element.uid == widget.user!.uid);

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
      var element_map = master.array_user[index].toDB();
      await FireStore().cancelFireStore(patch: dirDB, map: element_map);
      print('Cancellazione OK');

      master.array_user.removeAt(index);

      setState(() {
        master.gestion_Message('Dati cancellati correttamente');
        Navigator.pop(context);
        return;
      });

      return;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master
            .gestion_Message('Errore caricamento nel DB, ${error.toString()}');
        return;
      });
      return;
    }
  }
}
