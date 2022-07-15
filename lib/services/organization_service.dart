import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class OrganizationService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:8287';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<List<dynamic>?> OrganizationList() async {
    final url = Uri.parse('$_baseUrl/api/v1/Orga');

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

  Future<List<dynamic>?> OrganizationList2() async {
    final url = Uri.parse('$_baseUrl/api/v1/Orga');

    http.Response? resp;
    List<dynamic>? decodedResp;

    String? token = await readToken();

    try {
      resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      });
      decodedResp = json.decode(resp.body);
      //print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      //print('resultado = 200');
      //print(decodedResp);
      return decodedResp;
    } else {
      print('error');
      return null;
    }
  }

  Future<String?> OrganizationAdd(
      String idorga, String iduser, List<dynamic> roles) async {
    final Map<String, dynamic> newData = {
      'orgaId': idorga,
      'userId': iduser,
      'roles': roles
    };

    final url = Uri.parse('$_baseUrl/api/v1/Orga/users');

    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    String? token = await readToken();

    try {
      //print(json.encode(newData));
      resp = await http.post(url, body: json.encode(newData), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      });
      decodedResp = json.decode(resp.body);
      //print('antes del catch');
      print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      print('resultado = 200');
      print(decodedResp);
      return null;
    } else {
      print('error');
      return decodedResp!['message'];
    }
  }

  Future<String?> OrganizationDelete(
    String idorga,
    String iduser,
  ) async {
    final url = Uri.parse('$_baseUrl/api/v1/Orga/$idorga/users?userId=$iduser');

    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    final List<dynamic> datos = [resp, decodedResp, false];

    String? token = await readToken();

    try {
      //print(json.encode(newData));
      resp = await http.delete(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2] = true;
      decodedResp = json.decode(resp.body);
      datos[0] = resp;
      datos[1] = decodedResp;
      //print('antes del catch');
      print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      print('resultado = 200');
      print(decodedResp);
      return null;
    } else {
      print('error');
      return decodedResp!['message'];
    }
  }

  Future<List<dynamic>?> EnableDisable(String id, bool disabled) async {
    Uri? url;
    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    final List<dynamic> datos = [resp, decodedResp, false];

    String? token = await readToken();
    print(disabled);

    if (disabled) {
      url = Uri.parse('$_baseUrl/api/v1/Orga/disable?id=$id');
    } else {
      url = Uri.parse('$_baseUrl/api/v1/Orga/enable?id=$id');
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

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
