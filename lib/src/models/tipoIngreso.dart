// To parse this JSON data, do
//
//     final tipoIngreso = tipoIngresoFromMap(jsonString);

import 'dart:convert';

List<TipoIngreso> tipoIngresoFromMap(String str) =>
    List<TipoIngreso>.from(json.decode(str).map((x) => TipoIngreso.fromMap(x)));

String tipoIngresoToMap(List<TipoIngreso> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class TipoIngreso {
  int id;
  String descripcion;
  String sujeto;
  bool empresa;
  bool placa;
  bool fotoPlaca;
  bool cedula;
  bool fotoCedula;
  bool nombre;
  bool pasajero;
  bool calle;
  bool numero;

  TipoIngreso({
    required this.id,
    required this.descripcion,
    required this.sujeto,
    required this.empresa,
    required this.placa,
    required this.fotoPlaca,
    required this.cedula,
    required this.fotoCedula,
    required this.nombre,
    required this.pasajero,
    required this.calle,
    required this.numero,
  });

  TipoIngreso copyWith({
    int? id,
    String? descripcion,
    String? sujeto,
    bool? empresa,
    bool? placa,
    bool? fotoPlaca,
    bool? cedula,
    bool? fotoCedula,
    bool? nombre,
    bool? pasajero,
    bool? calle,
    bool? numero,
  }) =>
      TipoIngreso(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        sujeto: sujeto ?? this.sujeto,
        empresa: empresa ?? this.empresa,
        placa: placa ?? this.placa,
        fotoPlaca: fotoPlaca ?? this.fotoPlaca,
        cedula: cedula ?? this.cedula,
        fotoCedula: fotoCedula ?? this.fotoCedula,
        nombre: nombre ?? this.nombre,
        pasajero: pasajero ?? this.pasajero,
        calle: calle ?? this.calle,
        numero: numero ?? this.numero,
      );

  factory TipoIngreso.fromMap(Map<String, dynamic> json) => TipoIngreso(
        id: json["id"],
        descripcion: json["descripcion"],
        sujeto: json["sujeto"],
        empresa: json["empresa"],
        placa: json["placa"],
        fotoPlaca: json["fotoPlaca"],
        cedula: json["cedula"],
        fotoCedula: json["fotoCedula"],
        nombre: json["nombre"],
        pasajero: json["pasajero"],
        calle: json["calle"],
        numero: json["numero"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "descripcion": descripcion,
        "sujeto": sujeto,
        "empresa": empresa,
        "placa": placa,
        "fotoPlaca": fotoPlaca,
        "cedula": cedula,
        "fotoCedula": fotoCedula,
        "nombre": nombre,
        "pasajero": pasajero,
        "calle": calle,
        "numero": numero,
      };
}
