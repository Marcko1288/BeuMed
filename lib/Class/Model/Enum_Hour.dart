import 'package:flutter/material.dart';

enum SelectionHour {
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  H7,
  H8,
  H9;

  static SelectionHour code(String s) => switch (s) {
        'H1' => H1,
        'H2' => H2,
        "H3" => H3,
        'H4' => H4,
        'H5' => H5,
        "H6" => H6,
        'H7' => H7,
        'H8' => H8,
        "H9" => H9,
        _ => H1
      };

  static SelectionHour numer(int s) => switch (s) {
        1 => H1,
        2 => H2,
        3 => H3,
        4 => H4,
        5 => H5,
        6 => H6,
        7 => H7,
        8 => H8,
        9 => H9,
        _ => H1
      };

  static List<SelectionHour> arrayElement() {
    return [
      SelectionHour.H1,
      SelectionHour.H2,
      SelectionHour.H3,
      SelectionHour.H4,
      SelectionHour.H5,
      SelectionHour.H6,
      SelectionHour.H7,
      SelectionHour.H8,
      SelectionHour.H9
    ];
  }
}

extension ExtSelectionProfile on SelectionHour {
  String get value {
    switch (this) {
      case SelectionHour.H1:
        return '09:00 - 10:00';
      case SelectionHour.H2:
        return '10:00 - 11:00';
      case SelectionHour.H3:
        return '11:00 - 12:00';
      case SelectionHour.H4:
        return '12:00 - 13:00';
      case SelectionHour.H5:
        return '14:00 - 15:00';
      case SelectionHour.H6:
        return '15:00 - 16:00';
      case SelectionHour.H7:
        return '16:00 - 17:00';
      case SelectionHour.H8:
        return '17:00 - 18:00';
      case SelectionHour.H9:
        return '18:00 - 19:00';
      default:
        return '';
    }
  }

  int get number {
    switch (this) {
      case SelectionHour.H1:
        return 1;
      case SelectionHour.H2:
        return 2;
      case SelectionHour.H3:
        return 3;
      case SelectionHour.H4:
        return 4;
      case SelectionHour.H5:
        return 5;
      case SelectionHour.H6:
        return 6;
      case SelectionHour.H7:
        return 7;
      case SelectionHour.H8:
        return 8;
      case SelectionHour.H9:
        return 9;
      default:
        return 0;
    }
  }

  bool detIntevalDate(DateTime date_now) {

    DateTime().

    return false;


  }
}
