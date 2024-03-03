import 'dart:html';

import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/BUT000.dart';
import '../../Class/EVENT.dart';
import '../../Class/Master.dart';
import '../../Library/FireAuth.dart';
import '../../Library/FireStore.dart';
import '../../Model/DatePickerApp.dart';
import '../../Class/Model/Enum_TypeState.dart';

class Det_EventView extends StatefulWidget {
  Det_EventView({super.key, this.state = TypeState.read, this.event});

  late EVENT? event;
  late TypeState state;

  @override
  State<Det_EventView> createState() => Det_EventViewState();
}

class Det_EventViewState extends State<Det_EventView> {
  late BUT000 userSelected = BUT000.standard();
  late DateTime data_inizio = DateTime.now();
  late String note = '';

  final _formKey = GlobalKey<FormState>();

  List<String> array_noDate = [];
  List<SelectionHour> isTime = [];
  List<SelectionHour> isTimeSelection = [];

  @override
  void initState() {
    super.initState();
    refreshDate(context);
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

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
              SelectUser(context),
              SelectDataEvent(context),
              SelectHour(context),
              InsertNote(context),
            ],
          ),
        ),
      ),
      floatingActionButton: action_button(context),
    );
  }

  //Seleziona User
  Widget SelectUser(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return DropdownSearch<BUT000>(
        enabled: widget.state == TypeState.read ? false : true,
        items: master.array_user.where((element) => element.cf != '').toList(),
        itemAsString: (BUT000 element) => element.cf == ''
            ? 'Seleziona Paziente'
            : element.nome + ' ' + element.cognome + ' - ' + element.cf,
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        dropdownButtonProps:
            DropdownButtonProps(color: master.theme(size).primaryColor),
        dropdownDecoratorProps: DropDownDecoratorProps(
          //Bottone
          baseStyle: master.theme(size).textTheme.bodyMedium, //Testo mostrato nel campo
          textAlignVertical: TextAlignVertical.center,
          dropdownSearchDecoration: InputDecoration(
            enabledBorder: defaultBorder(master.theme(size).primaryColor),
            focusedBorder: defaultBorder(master.theme(size).primaryColor),
            errorBorder: defaultBorder(master.theme(size).primaryColor),
            disabledBorder: defaultBorder(master.theme(size).primaryColor),
            focusedErrorBorder: defaultBorder(master.theme(size).primaryColor),
          ),
        ),
        onChanged: (value) {
          setState(() {
            userSelected = value!;
            create_arrayHour(data_inizio);
          });
        },
        selectedItem: userSelected,
        validator: (valid) {
          if (valid is BUT000 && valid.cf == '')
            return 'Selezionare un Paziente!';
        });
  }

  //Seleziona Data
  Widget SelectDataEvent(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return DatePickerCustom(
      selection_date: data_inizio,
      min_year: DateTime.now().year,
      max_year: DateTime.now().add(Duration(days: 730)).year,
      array_nodate: array_noDate,
      modify: widget.state == TypeState.read ? false : true,
      onDateTimeChanged: (DateTime value) {
        setState(() {
          data_inizio = value;
          create_arrayHour(data_inizio);
        });
      },
    );
  }

  //Seleziona Hour
  Widget SelectHour(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
      child: GridView.count(
          crossAxisCount: size_width > 500 ? 3 : 2,
          childAspectRatio: size_width > 500 ? 6 : 4.5,
          children: List<Widget>.generate(isTime.length, (index) {
            var indexSelect = isTimeSelection!.contains(isTime[index]) ? 1 : 0;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: [
                InkWell(
                  onTap: widget.state == TypeState.read
                      ? null
                      : () {
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
                              isTimeSelection!.removeWhere(
                                  (element) => element == isTime[index]);
                              indexSelect = 0;
                              setState(() {});
                            }
                          });
                        },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: indexSelect == 1
                            ? master.theme(size).primaryColorLight //.shade100
                            : null,
                        border:
                            Border.all(color: master.theme(size).primaryColor),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          focusColor: Colors.white,
                          groupValue: indexSelect,
                          onChanged: null,
                          value: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 20),
                          child: Text(
                            isTime[index].value,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          })),
    );
  }

  //Inserimento Note
  Widget InsertNote(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return Expanded(
      child: TextFormField(
        initialValue: note,
        enabled: widget.state == TypeState.read ? false : true,
        maxLines: 10,
        decoration: InputDecoration(
          labelText: "Note",
          focusedBorder: defaultBorder(master.theme(size).primaryColor),
          enabledBorder: defaultBorder(master.theme(size).primaryColor),
          disabledBorder: defaultBorder(master.theme(size).primaryColor),
        ),
        onChanged: (String value) {
          setState(() {
            note = value;
          });
        },
      ),
    );
  }

  Widget action_button(BuildContext context) {
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
        return 'Modifica Appuntamento';
      case TypeState.insert:
        return 'Salva Appuntamento';
      case TypeState.modify:
        return 'Salva Appuntamento';
    }
  }

  DateTime detSelectionDate(){
    var array_no_date = array_holiday;
    array_no_date.addAll(array_noDate);
    var date_output = data_inizio;
    array_no_date.sort((a,b) => a.compareTo(b));

    if (date_output.weekday == 6) date_output = date_output.add(Duration(days: 2));
    if (date_output.weekday == 7) date_output = date_output.add(Duration(days: 1));

    for(var element in array_no_date){
      if (element.changeStringToDate().year > date_output.year) break;
      if (element == date_output.changeDateToString()) date_output.add(Duration(days: 1));
    }
    return date_output;
  }

  List<String> selectionNoDate() {
    //Crea un array di date in cui tutti gli appuntamenti sono già fissati.
    var master = Provider.of<Master>(context, listen: false);
    var array = master.array_event;
    List<String> array_output = [];
    array.sort((a, b) => (a.data_inizio.compareTo(b.data_inizio)));
    String selectDate = '';

    for (var element in array) {
      if (selectDate != element.data_inizio.changeDateToString()) {
        var length = master.array_event
            .where((elem) =>
                elem.data_inizio.changeDateToString() ==
                element.data_inizio.changeDateToString())
            .length;
        if (length >= 9) {
          array_output.add(element.data_inizio.changeDateToString());
        }
        selectDate = element.data_inizio.changeDateToString();
      }
    }
    return array_output;
  }

  void create_arrayHour(DateTime now_date) {
    var master = Provider.of<Master>(context, listen: false);
    var now_hour = SelectionHour.hour(DateTime.now());

    var array_app = master.array_event
        .where((element) =>
            element.data_inizio.changeDateToString() ==
            now_date.changeDateToString())
        .toList();
    isTime = SelectionHour.arrayElement();

    array_app.forEach((element) {print(element.printLine());});

    for (var element in array_app) {
      for (var hour in element.hours)
        isTime.removeWhere((eleTime) => eleTime == hour);
    }

    if (DateTime.now().changeDateToString() == now_date.changeDateToString())
      isTime.removeWhere((element) => element.number <= now_hour.number);

    if (userSelected.uidBUT000 != '') {
      var event_user =
          array_app.firstWhere((element) => element.uidBUT000 == userSelected.uid, orElse: EVENT.standard);

      if (event_user.uidBUT000 != '') {
        var hours = event_user.hours.toList();
        isTime.addAll(hours);
        isTimeSelection.clear();
        isTimeSelection.addAll(hours);
        widget.event = event_user;
      }
    }

    isTime.sort((a, b) => a.number.compareTo(b.number));

  }

  void refreshDate(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    setState(() {
      if (widget.state == TypeState.insert) {
        data_inizio = detSelectionDate();
        note = '';
      } else {
        userSelected = master.array_user.firstWhere((element) => element.uid == widget.event!.uidBUT000, orElse: BUT000.standard);
        data_inizio = widget.event!.data_inizio;
        note = widget.event!.note;
      }
      create_arrayHour(data_inizio);
      array_noDate = selectionNoDate();
    });
  }

  Future<void> deleteElement() async {
    var master = Provider.of<Master>(context, listen: false);
    var index = master.array_event
        .indexWhere((element) => element.uid == widget.event!.uid);

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'EVENT');
      var element_map = master.array_event[index].toDB();
      await FireStore().cancelFireStore(patch: dirDB, map: element_map);
      print('Cancellazione OK');

      master.array_event.removeAt(index);

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

  Future<void> actionElement() async {
    var master = Provider.of<Master>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      if (widget.state == TypeState.read){
        setState(() {
          widget.state = TypeState.modify;
        });
      } else {
        if (widget.state == TypeState.insert){
          if (widget.event == null){
            await insertElement();
          } else {
            await modifyElement();
          }
        }
        if (widget.state == TypeState.modify){
          await modifyElement();
        }
      }
    }
  }

  Future<void> insertElement() async {
    var master = Provider.of<Master>(context, listen: false);
    bool insert = true;

    if (insert == true) {
      var event = EVENT(
          uidBUT000: userSelected.uid,
          data_inizio: data_inizio,
          hours: isTimeSelection,
          note: note);

      try {
        var dirDB = FireStore()
            .dirDB(document: '${Auth().currentUser!.uid}', value: 'EVENT');
        var element_map = event.toDB();
        await FireStore().insertFirestore(patch: dirDB, map: element_map);
        print('Caricamento OK');
        widget.event = event;
        master.array_event.add(event);

        setState(() {
          master.gestion_Message('Dati caricati correttamente');
          widget.state = TypeState.read;
          refreshDate(context);
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
    var index = master.array_event
        .indexWhere((element) => element.uid == widget.event!.uid);
    master.array_event[index].data_inizio = data_inizio;
    master.array_event[index].hours = isTimeSelection;
    master.array_event[index].note = note;

    try {
      var dirDB = FireStore()
          .dirDB(document: '${Auth().currentUser!.uid}', value: 'EVENT');
      var element_map = master.array_event[index].toDB();
      await FireStore().modifyFireStore(patch: dirDB, map: element_map);
      print('Modifica OK');

      setState(() {
        master.gestion_Message('Dati modificati correttamente');
        widget.state = TypeState.read;
        refreshDate(context);
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

OutlineInputBorder defaultBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: color),
  );
}