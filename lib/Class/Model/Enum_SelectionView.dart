import 'package:flutter/material.dart';

///Le tipologie di valore che può assumere:
///
/// Login       --> View Login: Gestione login dell'app web

enum SelectionView {
  Login,
  ResetPassword,
  Home,
  User,
  Event,
  History,
}

extension ExtSelectionView on SelectionView {
  String get value {
    switch (this) {
      case SelectionView.Login:
        return 'BeuMed ®️';

      case SelectionView.ResetPassword:
        return 'Reset Password';

      case SelectionView.Home:
        return 'BeuMed ®️';

      case SelectionView.User:
        return 'Paziente';

      case SelectionView.Event:
        return 'Appuntamento';

      case SelectionView.History:
        return 'Agenda';

      default:
        return '';
    }
  }

  String get route {
    switch (this) {
      case SelectionView.Login:
        return '/login';

      case SelectionView.ResetPassword:
        return '/resetpassword';

      case SelectionView.Home:
        return '/home';

      case SelectionView.User:
        return '/user';

      case SelectionView.Event:
        return '/event';

      case SelectionView.History:
        return '/history';

      default:
        return '';
    }
  }
}
