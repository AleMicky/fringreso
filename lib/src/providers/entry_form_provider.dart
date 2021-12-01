import 'package:flutter/material.dart';
import 'package:fringreso/src/models/tipoIngreso.dart';

class EntryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  int idTipoIngreso = 0;
  String? placa;
  String? empresa;
  String? nombre;
  String? cedula;
  String? calle;
  String? numero;
  String pasajero = 'no';
  String? observacion;

  bool _isLoading = false;
  bool _ingreso = false;
  bool _placaBool = false;
  bool _empresaBool = false;
  bool _nombreBool = false;
  bool _cedulaBool = false;
  bool _calleBool = false;
  bool _numeroBool = false;
  bool _pasajeroBool = false;
  bool _fotoPlaca = false;
  bool _fotoCedula = false;

  bool get isLoading => _isLoading;
  bool get placaBool => _placaBool;
  bool get empresaBool => _empresaBool;
  bool get nombreBool => _nombreBool;
  bool get cedulaBool => _cedulaBool;
  bool get calleBool => _calleBool;
  bool get numeroBool => _numeroBool;
  bool get pasajeroBool => _pasajeroBool;
  bool get fotoPlaca => _fotoPlaca;
  bool get fotoCedula => _fotoCedula;
  bool get ingreso => _ingreso;

  void iniciarEvento(TipoIngreso tipo) {
    idTipoIngreso = tipo.id;
    _placaBool = tipo.placa;
    _empresaBool = tipo.empresa;
    _nombreBool = tipo.nombre;
    _cedulaBool = tipo.cedula;
    _calleBool = tipo.calle;
    _numeroBool = tipo.numero;
    _pasajeroBool = tipo.pasajero;
    _fotoPlaca = tipo.fotoPlaca;
    _fotoCedula = tipo.fotoCedula;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set ingreso(bool value) {
    _ingreso = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
