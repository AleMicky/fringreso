import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fringreso/src/models/ingreso.dart';
import 'package:fringreso/src/providers/auth_provider.dart';
import 'package:fringreso/src/util/app_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IngresarProvider with ChangeNotifier {
  final List<Ingreso> headlines = [];
  File? nuevaImagen;
  bool isSaving = false;
  bool isLoading = true;

  IngresarProvider() {
    this.loadIngreso();
  }

  Future<String?> crearIngreso(
    int? tipoFormularioId,
    String? empresa,
    String? placa,
    String? nombreCompleto,
    String? cedula,
    String? pasajero,
    String? calle,
    String? numero,
    int? evento,
    String? observacion,
  ) async {
    isSaving = true;

    final params = {
      "tipoIngresoId": tipoFormularioId,
      "entidad": empresa,
      "placa": placa,
      "nombreCompleto": nombreCompleto,
      "cedula": cedula,
      "pasajero": pasajero,
      "calle": calle,
      "numero": numero,
      "evento": evento,
      "observacion": observacion
    };

    final url = Uri.parse('${AppUrl.baseURL}/api/Ingreso');
    final auth = new AuthProvider();
    String key = await auth.readToken();
    final resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $key',
      },
      body: json.encode(params),
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    // Ingreso respData = decodedResp.map((value) => print(value));

    /*decodedResp.forEach((key, value) {
      final tmp = Ingreso.fromJson(value);
      print('${key}: ${value}');
      this.headlines.add(tmp);
    });*/

    isSaving = false;
    notifyListeners();

    /*
    print(decodedResp);

    print(decodedResp);
    if (decodedResp.containsKey('id')) {
      return null;
    } else {
      return decodedResp['message'];
    }*/
    return null;
  }

  getTopHeadlines() async {
    /*final auth = new AuthProvider();
    String key = await auth.readToken();

    final url = Uri.parse('${AppUrl.baseURL}/api/Ingreso');
    final resp = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $key',
    });
    final response = ingresoFromMap(resp.body);
    this.headlines.addAll(response);

    notifyListeners();*/
  }

  Future<List<Ingreso>> loadIngreso() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.parse('${AppUrl.baseURL}/api/Ingreso');

    final resp = await http.get(url);
    final ingresoMap = json.decode(resp.body).cast<Map<String, dynamic>>();
    List<Ingreso> rateJsonEntries =
        ingresoMap.map<Ingreso>((json) => Ingreso.fromJson(json)).toList();

    rateJsonEntries.forEach((value) {
      this.headlines.add(value);
    });

    this.isLoading = false;
    notifyListeners();
    return this.headlines;
  }

  /*List<Ingreso> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Ingreso>((json) => fromJson(json)).toList();
  }*/

  void updateSelectImagen(String path) {
    this.nuevaImagen = File.fromUri(Uri(path: path));
    this.isLoading = true;
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.nuevaImagen == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dkepyautb/image/upload?upload_preset=mccoa9gt');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', nuevaImagen!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    this.nuevaImagen = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
