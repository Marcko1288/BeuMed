import 'dart:html';

import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/BUT000.dart';
import '../Class/EVENT.dart';
import '../Class/Master.dart';
import '../Library/FireAuth.dart';
import '../Library/FireStore.dart';
import '../Model/DatePickerApp.dart';
import '../Class/Model/Enum_TypeState.dart';

class Det_EventView extends StatefulWidget {
  Det_EventView({super.key, this.state = TypeState.read, this.event});

  late EVENT? event;
  late TypeState state;

  @override
  State<Det_EventView> createState() => _Det_EventViewState();
}

class _Det_EventViewState extends State<Det_EventView> {
  late String title;
  late DateTime data_inizio = DateTime.now();
  //late SelectionHour hour = SelectionHour.H1;
  late String note = '';

  final _formKey = GlobalKey<FormState>();

  BUT000 userSelected = BUT000.standard();
  FocusNode myFocusNode = new FocusNode();

  List<String> array_nodate = [];

  int hourSelected = 0;

  List<SelectionHour> isTime = [];
  List<SelectionHour> isTimeSelection = [];

  void selectTime(int timeSelected) {
    setState(() {
      hourSelected = timeSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;
    var size_width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
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
        dropdownButtonProps: DropdownButtonProps(color: master.theme(size).primaryColor),
        dropdownDecoratorProps: DropDownDecoratorProps(     //Bottone
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
          userSelected = value!;
          create_arrayHour(data_inizio);
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
      array_nodate: nodateSelect(),
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
                      ? () {}
                      : () {
                          setState(() {
                            if (!isTimeSelection!.contains(isTime[index])) {
                              if (isTimeSelection!.length < 3) {
                                isTimeSelection!.add(isTime[index]);
                                indexSelect = 1;
                                //setState(() {});
                                print(isTimeSelection);
                              } else {
                                master.gestion_Message(
                                    'Non è possibile selezionare più di tre slot');
                              }
                            } else {
                              isTimeSelection!.removeWhere(
                                  (element) => element == isTime[index]);
                              indexSelect = 0;
                              setState(() {});
                              print(isTimeSelection);
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
          //labelStyle: TextStyle(color: Colors.lightGreen, fontSize: 15.0),
          labelText: "Note",
          //fillColor: Colors.white,
          focusedBorder:
          defaultBorder(master.theme(size).primaryColor),
          enabledBorder:
          defaultBorder(master.theme(size).primaryColor),
          disabledBorder:
          defaultBorder(master.theme(size).primaryColor),
        ),
        onChanged: (String value) {
          setState(() {
            note = value;
          });
        },
      ),
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
          title = "Appuntamento";
        case TypeState.insert:
          title = "Nuovo Appuntamento";
        case TypeState.modify:
          title = "Modifica Appuntamento";
      }
    });
  }

  List<String> nodateSelect() {
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
    var array_app = master.array_event.where((element) =>
            element.data_inizio.changeDateToString() == now_date.changeDateToString()).toList();
    isTime = SelectionHour.arrayElement();

    for(var element in array_app){
      for(var hour in element.hours)
        isTime.removeWhere((eleTime) => eleTime == hour);
    }

    if (DateTime.now().changeDateToString() == now_date.changeDateToString())
      isTime.removeWhere((element) => element.number <= now_hour.number);

    // if (widget.event?.hours != null)
    //   isTime.addAll(widget.event!.hours);

    isTimeSelection.clear();
    if (widget.event != null){
      isTime.addAll(widget.event!.hours);
      isTimeSelection.addAll(widget.event!.hours);
    }

    isTime.sort((a, b) => a.number.compareTo(b.number));

    //return isTime;
  }

  void refreshDate() {
    setState(() {
      detTitle();
      if (widget.state == TypeState.insert) {
        data_inizio = DateTime.now();
        note = '';
        //isTimeSelection = [];
      } else {
        data_inizio = widget.event!.data_inizio;
        note = widget.event!.note;
        //isTimeSelection = widget.event!.hours;
      }
      create_arrayHour(data_inizio);
      print(
          'isTimeSelection: ${isTimeSelection.length}, isTime: ${isTime.length}');
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
      if (widget.state != TypeState.read) {
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
    var index = master.array_event
        .indexWhere((element) => element.uid == widget.event!.uid);
    master.array_event[index].uidBUT000 = userSelected.uid;
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
}

OutlineInputBorder defaultBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: color),
  );
}

// if (widget.state == TypeState.read)
//   Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Center(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: InkWell(
//           onTap: () {},
//           child: Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 color:
//                     master.theme(size).primaryColorLight, //.shade100,
//                 border: Border.all(
//                     color: master.theme(size).primaryColor),
//                 borderRadius: BorderRadius.circular(20)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Radio(
//                   focusColor: Colors.white,
//                   groupValue: 0,
//                   onChanged: (timeSelected) {},
//                   value: 0,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 10, right: 20),
//                   child: Text(
//                     hour.value,
//                     //style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ),
//   ),
//if (widget.state != TypeState.read)
// Expanded(
//   child: GridView.count(
//       crossAxisCount: size_width > 500 ? 3 : 2,
//       childAspectRatio: size_width > 500 ? 6 : 4.5,
//       children: List<Widget>.generate(isTime.length, (index) {
//         if (isTimeSelection!.contains(isTime[index])) {
//           print('hourSelected: ${hourSelected}, index: ${index}');
//           hourSelected = index + 1;
//         }
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Stack(
//             children: [
//               InkWell(
//                 onTap: widget.state == TypeState.read
//                     ? () {}
//                     : () {
//                   setState(() {
//                     if (!isTimeSelection!
//                         .contains(isTime[index])) {
//                       if (isTimeSelection!.length < 3) {
//                         isTimeSelection!.add(isTime[index]);
//                         hourSelected = index + 1;
//                         //setState(() {});
//                         print(isTimeSelection);
//                       } else {
//                         master.gestion_Message(
//                             'Non è possibile selezionare più di tre slot');
//                       }
//                     } else {
//                       isTimeSelection!.removeWhere((element) =>
//                       element == isTime[index]);
//                       hourSelected = index + 1;
//                       setState(() {});
//                       print(isTimeSelection);
//                     }
//                   });
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: hourSelected == index + 1
//                           ? master
//                           .theme(size)
//                           .primaryColorLight //.shade100
//                           : null,
//                       border: Border.all(
//                           color: master.theme(size).primaryColor),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Radio(
//                         focusColor: Colors.white,
//                         groupValue: hourSelected,
//                         onChanged: (timeSelected) {
//                           setState(() {
//                             //   hourSelected = timeSelected!;
//                           });
//                         },
//                         value: index + 1,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 10, right: 20),
//                         child: Text(
//                           isTime[index].value,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ]
//           ),
//         );
//       })),
// ),

