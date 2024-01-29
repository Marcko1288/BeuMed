import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/Model/Enum_TypeState.dart';
import '../Class/BUT000.dart';
import '../Library/FireAuth.dart';
import '../Library/FireStore.dart';
import '../Model/TextFieldCustom.dart';

class Det_UserView extends StatefulWidget {
  Det_UserView({super.key, this.state = TypeState.read, this.user});

  late BUT000? user;
  late TypeState state;

  @override
  State<Det_UserView> createState() => _Det_UserViewState();
}

class _Det_UserViewState extends State<Det_UserView> {
  late String title;
  late String mail = "";
  late String cf = "";
  late String piva = "";
  late String nome = "";
  late String cognome = "";
  late SelectionProfile profilo = SelectionProfile.paziente;
  late String indirizzo = "";
  late String citta = "";
  late String cap = "";
  late String provincia = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    var size_width = MediaQuery.of(context).size.width;
    var size_height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
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
        child:
        GridView.count(childAspectRatio: 8,
            crossAxisCount: size_height > 300 ? 2 : 1,
            children: [
          TextFieldCustom(
              text: 'Nome',
              modify_text: nome,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                nome = value;
              },
              listValidator: [
                TypeValidator.required,
              ]),
          TextFieldCustom(
              text: 'Cognome',
              modify_text: cognome,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                cognome = value;
              },
              listValidator: [
                TypeValidator.required,
              ]),
          TextFieldCustom(
              text: 'Mail',
              modify_text: mail,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                mail = value;
              },
              listValidator: [TypeValidator.required, TypeValidator.email]),
          TextFieldCustom(
              text: 'Codice Fiscale',
              modify_text: cf,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                cf = value;
              },
              listValidator: [TypeValidator.required, TypeValidator.cf]),
          TextFieldCustom(
              text: 'Indirizzo',
              modify_text: indirizzo,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                indirizzo = value;
              },
              listValidator: []),
          TextFieldCustom(
              text: 'CAP',
              modify_text: cap,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              limit_char: 5,
              onStringChanged: (String value) {
                cap = value;
              },
              listValidator: []),
          TextFieldCustom(
              text: 'Città',
              modify_text: citta,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              onStringChanged: (String value) {
                citta = value;
              },
              listValidator: []),
          TextFieldCustom(
              text: 'Provincia',
              modify_text: provincia,
              enabled: widget.state == TypeState.read ? false : true,
              decoration: TypeDecoration.labolBord,
              limit_char: 2,
              onStringChanged: (String value) {
                provincia = value;
              },
              listValidator: []),

        ]),

      ),
      floatingActionButton: action_button(context),
    );
  }

  Widget action_button(BuildContext contextT) {
    return FloatingActionButton(
      onPressed: () {
        actionElement();
      },
      tooltip: 'Modifica Elemento',
      child: widget.state == TypeState.read
          ? Icon(Icons.mode_edit_outline_outlined)
          : Icon(Icons.save_as_outlined),
    );
  }

  void detTitle() {
    setState(() {
      switch (widget.state) {
        case TypeState.read:
          title = "Paziente";
        case TypeState.insert:
          title = "Nuovo Paziente";
        case TypeState.modify:
          title = "Modifica Paziente";
      }
    });
  }

  void refreshDate() {
    setState(() {
      detTitle();
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

    if(_formKey.currentState!.validate()){
      if(widget.state != TypeState.read){
        if (widget.state == TypeState.insert) {
          await insertElement();
        } else if (widget.state == TypeState.modify) {
          await modifyElement();
        }
      } else {
        setState(() {
          widget.state = TypeState.modify;
        });
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
          provincia: provincia);

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

extension WidgetDetUser on _Det_UserViewState {
  Container TextCampo(String string) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          string,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
