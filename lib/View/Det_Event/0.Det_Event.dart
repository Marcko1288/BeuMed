import 'package:beumed/Class/Model/Enum_Hour.dart';
import 'package:beumed/View/Det_Event/3.Fire_Det_Event.dart';
import 'package:beumed/View/Det_Event/2.Function_Det_Event.dart';
import 'package:beumed/View/Det_Event/1.1.Widget_Det_Event.dart';
import 'package:beumed/View/Det_Event/1.2.Box_SelectUser.dart';
import 'package:beumed/View/Det_Event/1.3.Box_SelectData.dart';
import 'package:beumed/View/Det_Event/1.4.Box_SelectHours.dart';
import 'package:beumed/View/Det_Event/1.5.Box_Note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/BUT000.dart';
import '../../Class/EVENT.dart';
import '../../Class/HOURS.dart';
import '../../Class/Master.dart';
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

  final formKey = GlobalKey<FormState>();

  List<String> array_noDate = [];
  List<Hours> isTime = [];
  List<Hours> isTimeSelection = [];

  @override
  void initState() {
    super.initState();
    refreshDate(context);
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
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
                SelectUser(context),
                SelectDataEvent(context),
                SelectHour(context),
                InsertNote(context),
                Container(
                  height: size_height * 0.1,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: action_button(context),
    );
  }
}
