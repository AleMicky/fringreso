import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fringreso/src/models/tipoIngreso.dart';
import 'package:fringreso/src/util/app_url.dart';

class TipoIngresoProvider with ChangeNotifier {
  List<TipoIngreso> headlines = [];

  TipoIngresoProvider() {
    this.getTopHeadlines();
  }
  getTopHeadlines() async {
    final url = Uri.parse('${AppUrl.baseURL}/api/TipoIngreso');

    final resp = await http.get(url);

    final newsResponse = tipoIngresoFromMap(resp.body);
    this.headlines.addAll(newsResponse);

    notifyListeners();
  }
}
