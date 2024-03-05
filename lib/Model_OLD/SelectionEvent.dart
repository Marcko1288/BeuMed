import 'package:beumed/Library/Extension_Date.dart';
import 'package:beumed/View/Det_Event/0.Det_Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Class/Model/Enum_Hour.dart';

extension SelectHours on State<Det_EventView> {


  Widget SelectHoursNew(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);
    var size = MediaQuery.of(context).size;



    return Text('Marco');
  }






}