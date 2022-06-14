import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PermissionsService extends ChangeNotifier {
  final String _baseUrl = 'http://localhost:8187';
  final storage = const FlutterSecureStorage();
  bool isLoading = true;

  Future<List<dynamic>?> PermissionsList() async {
    final url = Uri.parse('$_baseUrl/api/v1/Role');

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
      print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      print('resultado = 200');
      print(decodedResp);
      return decodedResp;
    } else {
      print('error');
      return null;
    }
  }

  Future<bool> EnableDisable(String name, bool disabled) async {
    Uri? url;
    http.Response? resp;
    List<dynamic>? decodedResp;

    String? token = await readToken();

    if (disabled) {
      url = Uri.parse('$_baseUrl/api/v1/Role/disable?name=$name');
    } else {
      url = Uri.parse('$_baseUrl/api/v1/Role/enable?name=$name');
    }

    try {
      resp = await http.put(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        'Authorization': 'Bearer $token',
      });
      decodedResp = json.decode(resp.body);
      print(decodedResp);
    } catch (e) {
      print('ERROR!');
      print(e.toString());
    }

    if (resp?.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

/*
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }*/

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
/*
  String datoPrueba() {
    return 'eltokenfalse';
  }

  Future<String> readPermiso() async {
    String token;
    token = await storage.read(key: 'token') ?? '';
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['role'];
  }*/
}
