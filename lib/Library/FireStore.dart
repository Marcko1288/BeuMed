import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Enum_TypeQuery.dart';

//import 'Firestore.dart';

//Installare il package: flutter pub add firebase_core
//Installare il package: flutter pub add cloud_firestore

class FireStore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> dirDB(
      {required String document, required String value}) {
    String db = 'Database';
    return _firebaseFirestore.collection(db).doc(document).collection(value);
  }

  Future<void> insertFirestore(
      {required CollectionReference patch,
      required Map<String, dynamic> map}) async {
    var route = patch.doc(map['uid']);
    if (!Uri.base.toString().contains('localhost')) {
      print('object');
      await route.set(map).onError((error, stackTrace) => print('$error'));
    }
  }

  Future<void> cancelFireStore(
      {required CollectionReference patch,
      required Map<String, dynamic> map}) async {
    var route = patch.doc(map['uid']);
    if (!Uri.base.toString().contains('localhost')) {
      // await route.delete().onError((error, stackTrace) => print('$error'));
    }
  }

  Future<void> modifyFireStore(
      {required CollectionReference patch,
      required Map<String, dynamic> map}) async {
    map['data_modify'] = DateTime.now();
    var route = patch.doc(map['uid']);
    if (!Uri.base.toString().contains('localhost')) {
      // await route.update(map).onError((error, stackTrace) => print('$error'));
    }
  }

  Future<List<Map<String, dynamic>>> queryFireStore(
      {required CollectionReference patch,
      TypeQuery type = TypeQuery.NE,
      String campo = '',
      String value = ''}) async {
    List<Map<String, dynamic>> map = [];
    var route =
        patchQuery(patch: patch, type: type, campo: campo, value: value);
    var elementQuery = await route.get().then((value) {
      for (var element in value.docs) {
        map.add(element.data() as Map<String, dynamic>);
      }
    }, onError: (e) {
      print("Error completing: $e");
      return [];
    }); //=> print("Error completing: $e"));
    return map;
  }

  Query patchQuery(
      {required CollectionReference patch,
      TypeQuery type = TypeQuery.NE,
      String campo = '',
      String value = ''}) {
    switch (type) {
      case TypeQuery.EQ:
        return patch.where(campo, isEqualTo: value);
      case TypeQuery.LT:
        return patch.where(campo, isLessThan: value);
      case TypeQuery.LE:
        return patch.where(campo, isLessThanOrEqualTo: value);
      case TypeQuery.GT:
        return patch.where(campo, isGreaterThan: value);
      case TypeQuery.GE:
        return patch.where(campo, isGreaterThanOrEqualTo: value);
      case TypeQuery.NE:
        return patch;
    }
  }
}
