import 'package:flutter/material.dart';

enum SelectionStatoCivile {
  S1,
  S2,
  S3,
  S4;


  static SelectionStatoCivile code(String s) => switch (s) {
    'S1' => S1,
    'S2' => S2,
    "S3" => S3,
    'S4' => S4,
      _ => S1
  };

  static List<SelectionStatoCivile> arrayElement() {
    return [
      SelectionStatoCivile.S1,
      SelectionStatoCivile.S2,
      SelectionStatoCivile.S3,
      SelectionStatoCivile.S4
    ];
  }
}

extension ExtSelectionStatoCivile on SelectionStatoCivile {
  String get value {
    switch (this) {
      case SelectionStatoCivile.S1:
        return 'Celibe/Nubile';
      case SelectionStatoCivile.S2:
        return 'Coniugato/a';
      case SelectionStatoCivile.S3:
        return 'Vedovo/a';
      case SelectionStatoCivile.S4:
        return 'Divorziato/a';
      default:
        return '';
    }
  }
}