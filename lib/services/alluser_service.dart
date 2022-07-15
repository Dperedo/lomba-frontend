import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:8287';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<List<dynamic>?> UserList() async {
    final url = Uri.parse('$_baseUrl/api/v1/User');

    http.Response? resp;
    List<dynamic>? decodedResp;

    final List<dynamic> datos = [resp, decodedResp, false];

    String? token = await readToken();

    try {
      resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2] = true;
      decodedResp = json.decode(resp.body);
      datos[0] = resp;
      datos[1] = decodedResp;
      //print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
      return datos;
    }

    if (resp.statusCode == 200) {
      //print('resultado = 200');
      //print(decodedResp);
      return datos;
    } else {
      print('error');
      return datos;
    }
  }

  Future<List<dynamic>?> EnableDisable(String id, bool disabled) async {
    Uri? url;
    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    final List<dynamic> datos = [resp, decodedResp, false];

    String? token = await readToken();
    //print(disabled);

    if (disabled) {
      url = Uri.parse('$_baseUrl/api/v1/User/disable?Id=$id');
    } else {
      url = Uri.parse('$_baseUrl/api/v1/User/enable?Id=$id');
    }

    try {
      resp = await http.put(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2] = true;
      decodedResp = json.decode(resp.body);
      datos[0] = resp;
      datos[1] = decodedResp;
      //print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
      return datos;
    }

    if (resp.statusCode == 200) {
      return datos;
    } else {
      return datos;
    }
  }

  Future<List<dynamic>?> SearchUser(String id) async {
    Uri? url;
    http.Response? resp;
    List<dynamic>? decodedResp;

    final List<dynamic> datos = [resp, decodedResp, false];

    String? token = await readToken();
    //print(disabled);
    url = Uri.parse('$_baseUrl/api/v1/User/$id/orgas');

    /*if (disabled) {
      url = Uri.parse('$_baseUrl/api/v1/User/disable?Id=$id');
    } else {
      url = Uri.parse('$_baseUrl/api/v1/User/enable?Id=$id');
    }*/

    try {
      resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2] = true;
      decodedResp = json.decode(resp.body);
      datos[0] = resp;
      datos[1] = decodedResp;
      //print('---------------------------------------------');
      //print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
      return datos;
    }

    if (resp.statusCode == 200) {
      return datos;
    } else {
      return datos;
    }
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
