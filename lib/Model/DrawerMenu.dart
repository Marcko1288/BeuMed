import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/Model/Enum_SelectionView.dart';
import '../View/HomeView/0.HomeView.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Testata
            Container(
              color: ThemeData().primaryColor,
              padding: EdgeInsets.only(
                  top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person_outline),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text(
                    '${master.user.nome} ${master.user.cognome}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    'PIVA: ${master.user.piva}',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '@: ${master.user.mail}',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            //Pagine
            Wrap(
              runSpacing: 16,
              children: [
                ListTile(
                    leading: Icon(Icons.bar_chart),
                    title: Text('Home'),
                    onTap: () {
                      master.selectionView = SelectionView.Home;
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomeView()));
                    }
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
