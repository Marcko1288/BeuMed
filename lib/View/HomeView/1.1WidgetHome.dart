import 'package:beumed/Class/Model/Enum_SelectionView.dart';
import 'package:beumed/View/HomeView/2.Function_Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Class/Master.dart';
import '../../Library/FireAuth.dart';
import '../../Model/ExpandableFab.dart';
import '0.HomeView.dart';

extension WidgetHome on HomeViewState {
  Widget Title_AppBar(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Text(
      master.selectionView.value,
      style: master
          .theme(size)
          .textTheme
          .titleLarge,
    );
  }

  Widget Action_AppBar(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 8),
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  Auth().singOut();
                },
                icon: Icon(Icons.logout)),
          ],
        ));
  }

  Widget FloatingActionButton_Home(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;

    return ExpandableFab(
      distance: 112,
      children: [
        FloatingActionButton(
          heroTag: 'btn1',
          onPressed: () {
            routeAddUser(null);
          },
          tooltip: 'Nuovo Paziente',
          child: const Icon(Icons.add_reaction_outlined),
        ),
        FloatingActionButton(
          heroTag: 'btn2',
          onPressed: () {
            routeAddEvent();
          },
          tooltip: 'Nuovo Appuntamento',
          child: const Icon(Icons.add_comment_outlined),
        ),
      ],
    );
  }
}
