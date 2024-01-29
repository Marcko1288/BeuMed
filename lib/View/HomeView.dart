import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beumed/Class/Model/Enum_SelectionView.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/BUT000.dart';
import '../Library/FireAuth.dart';
import '../Model/Box.dart';
import '../Model/BoxCalendar.dart';
import '../Model/DrawerMenu.dart';
import '../Model/ExplorMenu.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //late List<BUT000> array_user = BUT000.arrayElement(); //widget.extractSubContract(context, type: SelectionSubContractStor.DaRinnovare);

  _getRequests() {
    setState(() {
      //actionButton = !actionButton;
      //Inserire i dati che devono essere aggiornati
      //array_user = BUT000.arrayElement(); //widget.extractSubContract(context, type: SelectionSubContractStor.DaRinnovare);
    });
  }

  bool actionButton = false;

  @override
  void initState() {
    super.initState();
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
            child: Text(
              master.selectionView.value,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Auth().singOut();
                      },
                      icon: Icon(Icons.logout)),
                ],
              ))
        ],
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
                  BoxCalendar(),

                  // Box(
                  //   title_card: 'Pazienti',
                  //   array: array_user,
                  //   onPressed: () {},
                  //   onRefresh: _getRequests,
                  // ),
                ],
              ),
            ),
          )),
      floatingActionButton: ExpandableFab(
        initialOpen: actionButton,
        distance: 112,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              routeAddUser(context);
            }, //() => {},
            tooltip: 'Nuovo Paziente',
            child: const Icon(Icons.add_reaction_outlined),
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              routeAddEvent(context);
            }, //() => {},
            tooltip: 'Nuovo Appuntamento',
            child: const Icon(Icons.add_comment_outlined),
          ),
        ],
      ),
    );
  }

  void routeAddUser(BuildContext contextT) {
    setState(() {
      Navigator.pushNamed(contextT, SelectionView.User_Add.route,
              arguments: RouteElement(SelectionView.User_Add.value, null))
          .then((val) => {_getRequests()});
    });
  }

  void routeAddEvent(BuildContext contextT) {
    setState(() {
      Navigator.pushNamed(contextT,
              SelectionView.Event_Add.route, //SelectionView.User_Add.route,
              arguments: RouteElement(SelectionView.Event_Add.value,
                  null //SelectionView.User_Add.value, null
                  ))
          .then((val) => {_getRequests()});
    });
  }
}
