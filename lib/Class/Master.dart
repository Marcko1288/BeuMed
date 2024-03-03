import 'package:flutter/material.dart';

import '../View/Det_Event/Det_Event.dart';
import '../View/Det_User/Det_User.dart';
import '../View/HomeView.dart';
import '../View/LoginView.dart';
import '../View/NavLink.dart';
import '../View/ResetPasswordView.dart';
import 'EVENT.dart';
import 'Model/Enum_SelectionView.dart';
import 'Model/Enum_TypeState.dart';
import 'BUT000.dart';

class Master with ChangeNotifier {
  final messageVideo = GlobalKey<ScaffoldMessengerState>();

  late SelectionView selectionView; //View Selezionata
  late BUT000 user; //Utente Loggato
  late List<BUT000> array_user; //Pazienti
  late List<EVENT> array_event; //Appuntamenti
  late List<Anamnesi> array_anamnesi;

  Master.standard()
      : this.array_user = [],
        this.array_event = [],
        this.array_anamnesi = [],
        this.selectionView = SelectionView.Login;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments as RouteElement;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginView());
      case '/resetpassword':
        return MaterialPageRoute(builder: (context) => ResetPasswordView());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomeView());
      case '/user':
        var element = args.element is BUT000 ? args.element as BUT000 : null;
        var state = element == null ? TypeState.insert : TypeState.read;
        return MaterialPageRoute(
            builder: (context) => Det_UserView(state: state, user: element));
      case '/event':
        var element = args.element is EVENT ? args.element as EVENT : null;
        var state = element == null ? TypeState.insert : TypeState.read;
        return MaterialPageRoute(
            builder: (context) => Det_EventView(state: state, event: element));
      case '/history':
        return MaterialPageRoute(builder: (context) => NavLink());
      default:
        return MaterialPageRoute(builder: (context) => NavLink());
    }
  }

  void gestion_Message(String message) {
    var snackBar = SnackBar(content: Text(message));
    this.messageVideo.currentState?.showSnackBar(snackBar);
  }

  void logOut() {
    this.selectionView = SelectionView.Login;
    this.user = BUT000.standard();
    this.array_user.clear();
    this.array_event.clear();
  }

  int crossGrid(Size size) {
    if (size.width > 1000) {
      return 2;
    } else {
      return 1;
    }
  }

  double childGrid(Size size) {
    return size.width / (size.height / 3.4);
  }

  ThemeData theme(Size size) {
    var type_device = size.width > 500 ? true : false;
    var colorPrimary = type_device ? Colors.lightGreen : Colors.lightBlue;
    var colorSecond =
        type_device ? Colors.lightGreen.shade100 : Colors.lightBlue.shade100;
    var sizeTextLarge = type_device ? 15.0 : 10.0;
    var sizeTextMedium = type_device ? 12.0 : 8.0;
    var sizeTextSmall = type_device ? 10.0 : 6.0;

    return ThemeData(
      colorScheme: type_device
          ? ColorScheme.fromSeed(seedColor: Colors.green)
          : ColorScheme.fromSeed(seedColor: Colors.blue),
      primaryColor: colorPrimary,
      primaryColorLight: colorSecond,
      textTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: type_device ? 30.0 : 20, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            fontSize: type_device ? 20.0 : 10, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(
            fontSize: type_device ? 10.0 : 5, fontWeight: FontWeight.bold),
        displayLarge: TextStyle(
            fontSize: sizeTextLarge,
            color: Colors.green,
            fontWeight: FontWeight.bold),
        displayMedium: TextStyle(
            fontSize: sizeTextMedium,
            color: Colors.green,
            fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            fontSize: sizeTextSmall,
            color: Colors.green,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: sizeTextLarge),
        headlineMedium: TextStyle(fontSize: sizeTextMedium),
        headlineSmall: TextStyle(fontSize: sizeTextSmall),
        bodyLarge: TextStyle(fontSize: sizeTextLarge),
        bodyMedium: TextStyle(fontSize: sizeTextMedium),
        bodySmall: TextStyle(fontSize: sizeTextSmall),
        labelLarge: TextStyle(
            fontSize: sizeTextLarge,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
            fontSize: sizeTextMedium,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        labelSmall: TextStyle(
            fontSize: sizeTextSmall,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class RouteElement {
  final String title;
  late dynamic element;

  RouteElement(this.title, this.element);
}
