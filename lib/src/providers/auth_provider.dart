import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fringreso/src/util/app_url.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  final storage = new FlutterSecureStorage();
  Future<String?> login(String cuenta, String password) async {
    final authData = {'cuenta': cuenta, 'password': password};
    final url = Uri.parse('${AppUrl.baseURL}/api/Cuentas/login');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(authData),
    );
    Map<String, dynamic> decodedResp = json.decode(resp.body);
    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['message'];
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
