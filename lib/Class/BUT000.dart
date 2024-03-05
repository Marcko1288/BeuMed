import 'dart:html';

import 'package:beumed/Class/Model/Enum_StatoCivile.dart';
import 'package:flutter/material.dart';
import 'package:beumed/Class/Model/Enum_Profile.dart';
import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/Library/Extension_String.dart';
import 'package:uuid/uuid.dart';

import '../Library/Enum_TypeExtraction.dart';

class BUT000 {
  //Variabili
  late String uid;
  late String mail;
  late String cf;
  late String piva;
  late String nome;
  late String cognome;
  late DateTime birthday;
  late String local_birthday;
  late SelectionProfile profilo;
  late String indirizzo;
  late int cap;
  late String citta;
  late String provincia;
  late int phone;
  late int mobile_phone;
  late SelectionStatoCivile stato_civile;
  late String uidBUT000;
  late List<Anamnesi> array_anamnesi;
  late List<Note> array_note;
  late DateTime data_ins;
  late DateTime data_modify;

  //Costruttore
  BUT000(
      {String? uid,
      String? cf,
      String? piva,
      SelectionProfile? profilo,
      String? indirizzo,
      int? cap,
      String? citta,
      String? provincia,
      List<Anamnesi>? array_anamnesi,
      List<Note>? array_note,
      required this.mail,
      required this.nome,
      required this.cognome,
      DateTime? birthday,
      String? local_birthday,
      int? phone,
      int? mobile_phone,
      SelectionStatoCivile? stato_civile,
      required this.uidBUT000,
      DateTime? data_ins,
      DateTime? data_modify})
      : this.uid = uid ?? Uuid().v4().toUpperCase(),
        this.cf = cf ?? '',
        this.piva = piva ?? '',
        this.birthday = birthday ?? DateTime.now(),
        this.local_birthday = local_birthday ?? '',
        this.profilo = profilo ?? SelectionProfile.paziente,
        this.indirizzo = indirizzo ?? '',
        this.cap = cap ?? 00000,
        this.citta = citta ?? '',
        this.provincia = provincia ?? '',
        this.phone = phone ?? 0,
        this.mobile_phone = mobile_phone ?? 0,
        this.stato_civile = stato_civile ?? SelectionStatoCivile.S1,
        this.array_anamnesi = array_anamnesi ?? [],
        this.array_note = array_note ?? [],
        this.data_ins = data_ins ?? DateTime.now(),
        this.data_modify = data_modify ?? DateTime.now();

  //Default
  BUT000.standard({
    this.mail = '',
    this.nome = '',
    this.cognome = '',
    this.cf = '',
    this.uidBUT000 = '',
  }) : this.uid = '';

  //FROM JSON
  factory BUT000.fromJson(Map<String, dynamic> json) {
    return BUT000(
      uid: json['uid'].runtimeType == 'String' ? json['uid'].toString() : '',
      mail: json['mail'].runtimeType == 'String' ? json['mail'].toString() : '',
      cf: json['cf'].runtimeType == 'String' ? json['cf'].toString() : '',
      piva: json['piva'].runtimeType == 'String' ? json['piva'].toString() : '',
      nome: json['nome'].runtimeType == 'String' ? json['nome'].toString() : '',
      cognome: json['cognome'].runtimeType == 'String' ? json['cognome'].toString() : '',
      indirizzo: json['indirizzo'].runtimeType == 'String' ? json['indirizzo'].toString() : '',
      cap: json['cap'].runtimeType == 'String' ? json['cap'].toString().changeStringToInt() : 00000,
      citta: json['citta'].runtimeType == 'String' ? json['citta'].toString() : '',
      provincia: json['provincia'].runtimeType == 'String' ? json['provincia'].toString() : '',
      uidBUT000: json['uidBUT000'].runtimeType == 'String' ? json['uidBUT000'].toString() : '',
      birthday: json['birthday'].runtimeType == 'String' ? json['birthday'].toString().changeStringToDate() : DateTime.now(),
      local_birthday: json['local_birthday'].runtimeType == 'String' ? json['local_birthday'].toString() : '',
      phone: json['phone'].runtimeType == 'String' ? json['phone'].toString().changeStringToInt() : 0,
      mobile_phone: json['mobile_phone'].runtimeType == 'String' ? json['mobile_phone'].toString().changeStringToInt() : 0,
      stato_civile: json['stato_civile'].runtimeType == 'String' ? SelectionStatoCivile.code(json['stato_civile'].toString()) : SelectionStatoCivile.S1,
      profilo: json['profilo'].runtimeType == 'String' ? SelectionProfile.code(json['profilo'].toString()) : SelectionProfile.paziente,
      array_anamnesi: json['array_anamnesi'] is Iterable ? List.from(json['array_anamnesi']) : [],
      array_note: json['array_note'] is Iterable ? List.from(json['array_note']) : [],
      data_ins: json['data_ins'].runtimeType == 'String' ? json['data_ins'].toString().changeStringToDate() : DateTime.now(),
      data_modify: json['data_modify'].runtimeType == 'String' ? json['data_modify'].toString().changeStringToDate() : DateTime.now(),
    );
  }

  //TO JSON
  Map<String, dynamic> toDB() => {
        'uid': uid,
        'mail': mail,
        'cf': cf,
        'piva': piva,
        'nome': nome,
        'cognome': cognome,
        'profilo': profilo,
        'indirizzo': indirizzo,
        'cap': cap,
        'citta': citta,
        'provincia': provincia,
        'uidBUT000': uidBUT000,
    'birthday' : birthday,
    'local_birthday' : local_birthday,
    'phone' : phone,
    'mobile_phone' : mobile_phone,
    'stato_civile' : stato_civile,
    'array_anamnesi' : array_anamnesi,
    'array_note' : array_note,
        'data_ins': data_ins,
        'data_modify': data_modify
      };

  //Stampa Testata
  String printFirstLine() {
    return 'UID;Mail;CF;PIVA;Nome;Cognome;Profilo;Indirizzo;'
        'Cittá;CAP;Provincia;Data di Nascita;Luogo di Nascita;Telefono;Cellulare;'
        'Anamnesi;Note'
        'Data Inserimento;Data Modifica';
  }

  //Stampa Elementi
  String printLine() {
    return '${this.uid};'
        '${this.mail};'
        '${this.cf};'
        '${this.piva};'
        '${this.nome};'
        '${this.cognome};'
        '${this.profilo};'
        '${this.indirizzo};'
        '${this.citta};'
        '${this.cap};'
        '${this.provincia};'
        '${this.birthday};'
        '${this.local_birthday};'
        '${this.phone};'
        '${this.mobile_phone};'
        '${this.array_anamnesi.length};'
        '${this.array_note.length};'
        '${this.uidBUT000};'
        '${this.data_ins.changeDateToString()};'
        '${this.data_modify.changeDateToString()};';
  }

  //Estrazione Single/Multy JSON
  dynamic extractionDB(
      {required Map<String, dynamic> dictionary,
      TypeExtraction type = TypeExtraction.multy}) {
    if (dictionary.isEmpty) {
      switch (type) {
        case TypeExtraction.single:
          dynamic dic = dictionary.keys.toList().first;
          return BUT000.fromJson(dic);
        case TypeExtraction.multy:
          List<BUT000> array = [];
          for (var dic in dictionary.values) {
            array.add(BUT000.fromJson(dic));
          }
          return array;
      }
    }
  }

  //Array Esempio
  static List<BUT000> arrayElement(String uidBUT000) {
    List<BUT000> array = [];
    array.add(BUT000(
        mail: "niko.ortolani1@gmail.com",
        cf: "ABCDEF12A34B123G",
        nome: "Niko",
        cognome: "Ortolani",
        uidBUT000: uidBUT000));

    array.add(BUT000(
        mail: "m.andreotti@aciemmeautomobili.it",
        piva: "Pika86chu",
        cf: "ABCDEF12A34B123G",
        nome: "Michele",
        cognome: "Andreotti",
        uidBUT000: uidBUT000));

    array.add(BUT000(
        mail: "giorgiaasinaro@gmail.com",
        cf: "ABCDEF12A34B123G",
        nome: "Giorgia",
        cognome: "Asinaro",
        uidBUT000: uidBUT000));

    array.add(BUT000(
        mail: "sdasfsafsd@gmail.com",
        piva: "Pippo",
        cf: "ABCDEF12A34B123G",
        nome: "Pippo",
        cognome: "Asinaro",
        uidBUT000: uidBUT000));

    array.add(BUT000(
        mail: "asdwqe3e@gmail.com",
        piva: "Pluto",
        cf: "ABCDEF12A34B123G",
        nome: "Pluto",
        cognome: "Pluto",
        uidBUT000: uidBUT000));
    return array;
  }
}

class Note {
  late String uid;
  late DateTime data;
  late String nota;
  late List<String> url_images;
  late DateTime data_ins;
  late DateTime data_modify;

  Note(
      {String? uid,
      required this.data,
      required this.nota,
      List<String>? url_images,
      DateTime? data_ins,
      DateTime? data_modify})
      : this.uid = uid ?? Uuid().v4().toUpperCase(),
        this.url_images = url_images ?? [],
        this.data_ins = data_ins ?? DateTime.now(),
        this.data_modify = data_modify ?? DateTime.now();
}

class Anamnesi {
  late String uid;
  late String nome;
  late bool? value;
  late String other;
  late bool enable;
  late DateTime data_ins;
  late DateTime data_modify;

  Anamnesi(
      {String? uid,
      required this.nome,
      required this.value,
      String? other,
      bool? enable,
      DateTime? data_ins,
      DateTime? data_modify})
      : this.uid = uid ?? Uuid().v4().toUpperCase(),
        this.other = other ?? '',
        this.enable = enable ?? true,
        this.data_ins = data_ins ?? DateTime.now(),
        this.data_modify = data_modify ?? DateTime.now();

  Anamnesi.standard({
    this.nome = '',
    this.value = false,
  })  : this.uid = Uuid().v4().toUpperCase(),
        this.other = '',
        this.enable = true,
        this.data_ins = DateTime.now(),
        this.data_modify = DateTime.now();

  //Array Esempio
  static List<Anamnesi> defaultElement() {
    List<Anamnesi> array = [];
    defaultAnamnesi.forEach((key, value) {
      array.add(Anamnesi(nome: key, value: value));
    });

    return array;
  }
}

Map<String, dynamic?> defaultAnamnesi = {
  'Vaccinazione antitetanica': null,
  'Fuma?': null,
  'Beve alcolici? (vino, birra, superalcolici…)': null,
  'Allergie': null,
  'Anemia': null,
  'Svenimenti': null,
  'Palpitazioni': null,
  'Vertigini': null,
  'Pressione elevata': null,
  'Colesterolo elevato': null,
  'Malattie del fegato/vie biliari': null,
  'Malattie neurologiche': null,
  'Neoplasie': null,
  'Malattie dei reni/vie urinarie': null,
  'Asma bronchiale': null,
  'Otiti/sinusiti': null,
  'Epilessia': null,
  'Malattie di cuore': null,
  'Dolore toracico': null,
  'Disturbi visivi': null,
  'Diabete mellito': null,
  'Malattie gastro-intestinali': null,
  'Malattie muscolo-scheletriche': null,
  'Malattie tiroidee': null,
  'Malattie psichiatriche': null,
};
