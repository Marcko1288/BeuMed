import 'package:flutter/material.dart';

enum SelectionProfile {
  admin,
  doc,
  paziente,
  segretaria;

  static SelectionProfile code(String s) => switch (s) {
    'ADMIN' => admin,
    'DOC' => doc,
    "PAZ" => paziente,
    "SEGR" => segretaria,
    _ => paziente
  };
}

extension ExtSelectionProfile on SelectionProfile {
  String get value {
    switch (this) {
      case SelectionProfile.admin:
        return 'ADMIN';

      case SelectionProfile.doc:
        return 'DOT';

      case SelectionProfile.paziente:
        return 'PAZ';

      case SelectionProfile.segretaria:
        return 'SEGR';

      default:
        return '';
    }
  }
}

