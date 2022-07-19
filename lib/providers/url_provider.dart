import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_lomba/helpers/preferences.dart';

import 'package:flutter/services.dart' show rootBundle;


Future<String> buscarUrl(String altUrl) async {
  Map<String, dynamic> resp;
    final value = await rootBundle.loadString('data/json_url.json');
    resp = json.decode(value);
    final url = resp["url"].toString();
    if(altUrl != '') {
      print(altUrl);
      Preferences.baseUrl = altUrl.toString();
    } else {
      print('falso');
      Preferences.baseUrl = url;  
    }
    //Le entrga la url a baseUrl del Preferences
    //No se utiliza el return
    return url;
}

