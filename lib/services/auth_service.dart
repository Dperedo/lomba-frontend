import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'http://localhost:8187';
  //final String token = ''; 
  final storage = const FlutterSecureStorage();
  bool isLoading = true;


  Future<String?> login( String email, String password ) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };print('1');print(readToken());

    final url = Uri.https(_baseUrl, '/api/v1/User/authenticate', {
      //'key': token
      'Headers': 'Bearer ${ readToken() }'
    });print('2');

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode( resp.body );
    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
        // Token hay que guardarlo en un lugar seguro
        // decodedResp['idToken'];
        await storage.write(key: 'token', value: decodedResp['idToken']);
        return null;
    } else {
      return decodedResp['error']['message'];
    }

  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {

    return await storage.read(key: 'token') ?? '';

  }


}
