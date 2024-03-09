import 'package:beumed/View/HomeView/1.1WidgetHome.dart';
import 'package:beumed/View/HomeView/1.2.Box_Calendar.dart';
import 'package:beumed/View/HomeView/2.Function_Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/EVENT.dart';
import '../../Class/Master.dart';
import '../../Model/DrawerMenu.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  //late List<BUT000> array_user = BUT000.arrayElement(); //widget.extractSubContract(context, type: SelectionSubContractStor.DaRinnovare)
  late List<Hours> array_hours = [];

  @override
  void initState() {
    super.initState();
    refreshDate();
  }

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 60),
          child: Align(
            alignment: Alignment.center,
            child: Title_AppBar(context),
          ),
        ),
        actions: [ Action_AppBar(context)],
      ),
      drawer: DrawerMenu(),
      body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BoxAgenda(context),
                ],
              ),
            ),
          )
      ),
      floatingActionButton: FloatingActionButton_Home(context)
    );
  }
}
