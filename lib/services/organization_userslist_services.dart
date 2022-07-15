import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:front_lomba/helpers/preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class OrganizationUserslistService extends ChangeNotifier {
  final String _baseUrl = Preferences.baseUrl;
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<List<dynamic>?> OrganizationUserslist(String id) async {
    print(id);
    final url = Uri.parse('$_baseUrl/api/v1/Orga/$id/users');

    http.Response? resp;
    List<dynamic>? decodedResp;
    
    final List<dynamic> datos = [resp,decodedResp,false];

    String? token = await readToken();

    try {
      resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2]=true;
      decodedResp = json.decode(resp.body);
      datos[0]=resp;
      datos[1]=decodedResp;
      //print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
      return datos;
    }

    if (resp.statusCode == 200) {
      print('resultado = 200');
      print(decodedResp);
      return datos;
    } else {
      print('error');
      return datos;
    }
  }

  Future<List<dynamic>?> EnableDisable(String id,String userId, bool disabled) async {
    Uri? url;
    http.Response? resp;
    Map<String, dynamic>? decodedResp;

    final List<dynamic> datos = [resp,decodedResp,false];

    String? token = await readToken();
    print(disabled);

    if (disabled) {
      url = Uri.parse('$_baseUrl/api/v1/Orga/$id/users/disable?userId=$userId');
    } else {
      url = Uri.parse('$_baseUrl/api/v1/Orga/$id/users/enable?userId=$userId');
    }

    try {
      resp = await http.put(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2]=true;
      decodedResp = json.decode(resp.body);
      datos[0]=resp;
      datos[1]=decodedResp;
      print(decodedResp);
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

  Future<List<dynamic>?> DeleteUsers(String id,String userId) async {
    Uri? url;
    http.Response? resp;
    Map<String, dynamic>? decodedResp;
    
    final List<dynamic> datos = [resp,decodedResp,false];

    String? token = await readToken();

    url = Uri.parse('$_baseUrl/api/v1/Orga/$id/users?userId=$userId');
    
    try {
      resp = await http.delete(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 10));
      datos[2]=true;
      decodedResp = json.decode(resp.body);
      datos[0]=resp;
      datos[1]=decodedResp;
      print(decodedResp);
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