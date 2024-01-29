import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:beumed/Class/Model/Enum_SelectionView.dart';
import 'package:beumed/View/HomeView.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../Class/EVENT.dart';
import '../Class/Master.dart';
import '../Class/BUT000.dart';
import '../Library/FireAuth.dart';
import 'LoginView.dart';
import 'NavLink.dart';

class GestureView extends StatefulWidget {
  const GestureView({super.key});

  @override
  State<GestureView> createState() => _GestureViewState();
}

class _GestureViewState extends State<GestureView> {
  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size_width = MediaQuery.of(context).size.width;

    return MaterialApp(
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('it', 'IT'),
      ],
      scaffoldMessengerKey: context.watch<Master>().messageVideo,
      title: context.watch<Master>().selectionView.value,
      theme: size_width > 500 ? themeWeb() : themeMobile(),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoginView();
          } else {
            return FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return HomeView();
                  } else if (snapshot.hasError) {
                    return TextButton(
                        onPressed: logOut, child: Text('Dati non scaricati!'));
                  }
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                });
          }
        },
      ),
      onGenerateRoute: Master.generateRoute, // Master.generateRoute,
    );
  }

  Future<bool> getData() async {
    var master = Provider.of<Master>(context, listen: false);

    try {
      print('Estrazione');

      //Estrai BUT000
      // var dirDB_user = FireStore().dirDB(document: '${Auth().currentUser!.uid}', value: 'BUT000');
      // var array_user = await FireStore().queryFireStore(patch: dirDB_user);
      // master.array_user.clear();
      // array_user.forEach((element) {
      //   var user = User.fromJson(element);
      //   master.array_user.add(user);
      //   if(user.uid == Auth().currentUser!.uid) master.user = user;
      // });

      master.user = BUT000(
          mail: 'marc.costigliola@gmail.com',
          nome: 'Marco',
          cognome: 'Costigliola',
          cf: 'CSTMRC',
          piva: '123456789',
          uidBUT000: '');
      master.array_user = BUT000.arrayElement(master.user.uid);
      master.array_event = EVENT.arrayElement(master.array_user[0].uid);

      print('Estrazione OK');
      master.selectionView = SelectionView.Home;

      return true;
    } on FirebaseException catch (error) {
      print('${error.toString()}');
      setState(() {
        master.gestion_Message(
            'Autentificazione Fallita! Verificare Email/Passord inseriti. \n ${error.toString()}');
      });
      return false;
    }
  }

  Future<void> logOut() async {
    var master = Provider.of<Master>(context, listen: false);

    master.logOut();
    Auth().singOut();
  }

  ThemeData themeMobile() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      primaryColor: Colors.lightGreen,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        displayLarge: TextStyle(fontSize: 10.0, color: Colors.yellow),
        displayMedium: TextStyle(fontSize: 6.0, color: Colors.yellow),
        displaySmall: TextStyle(fontSize: 4.0, color: Colors.yellow),
        headlineLarge: TextStyle(fontSize: 10.0, color: Colors.red),
        headlineMedium: TextStyle(fontSize: 6.0, color: Colors.red),
        headlineSmall: TextStyle(fontSize: 4.0, color: Colors.red),
        bodyLarge: TextStyle(fontSize: 10.0, color: Colors.green),
        bodyMedium: TextStyle(fontSize: 6.0, color: Colors.green),
        bodySmall: TextStyle(fontSize: 4.0, color: Colors.green),
        labelLarge: TextStyle(fontSize: 10.0, color: Colors.blue),
        labelMedium: TextStyle(fontSize: 6.0, color: Colors.blue),
        labelSmall: TextStyle(fontSize: 4.0, color: Colors.blue),
      ),
    );
  }

  ThemeData themeWeb() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      primaryColor: Colors.lightGreen,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        displayLarge: TextStyle(fontSize: 15.0, color: Colors.yellow),
        displayMedium: TextStyle(fontSize: 12.0, color: Colors.yellow),
        displaySmall: TextStyle(fontSize: 10.0, color: Colors.yellow),
        headlineLarge: TextStyle(fontSize: 15.0, color: Colors.red),
        headlineMedium: TextStyle(fontSize: 12.0, color: Colors.red),
        headlineSmall: TextStyle(fontSize: 10.0, color: Colors.red),
        bodyLarge: TextStyle(fontSize: 15.0, color: Colors.green),
        bodyMedium: TextStyle(fontSize: 12.0, color: Colors.green),
        bodySmall: TextStyle(fontSize: 10.0, color: Colors.green),
        labelLarge: TextStyle(fontSize: 15.0, color: Colors.blue),
        labelMedium: TextStyle(fontSize: 12.0, color: Colors.blue),
        labelSmall: TextStyle(fontSize: 10.0, color: Colors.blue),
      ),
    );
  }
}
