// To parse this JSON data, do
//
//     final ingreso = ingresoFromJson(jsonString);

import 'dart:convert';

Ingreso ingresoFromJson(String str) => Ingreso.fromJson(json.decode(str));

String ingresoToJson(Ingreso data) => json.encode(data.toJson());

class Ingreso {
  int? id;
  int? tipoIngresoId;
  String? tipo;
  String? empresa;
  String? placa;
  String? nombreCompleto;
  String? cedula;
  String? pasajero;
  String? calle;
  String? numero;
  String? observacion;
  DateTime fecha;
  String? evento;

  Ingreso({
    this.id,
    this.tipoIngresoId,
    this.tipo,
    this.empresa,
    this.placa,
    this.nombreCompleto,
    this.cedula,
    this.pasajero,
    this.calle,
    this.numero,
    this.observacion,
    required this.fecha,
    this.evento,
  });

  factory Ingreso.fromJson(Map<String, dynamic> json) => Ingreso(
        id: json["id"],
        tipoIngresoId: json["tipoIngresoId"],
        tipo: json["tipo"],
        empresa: json["empresa"],
        placa: json["placa"],
        nombreCompleto: json["nombreCompleto"],
        cedula: json["cedula"],
        pasajero: json["pasajero"],
        calle: json["calle"],
        numero: json["numero"],
        observacion: json["observacion"],
        fecha: DateTime.parse(json["fecha"]),
        evento: json["evento"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoIngresoId": tipoIngresoId,
        "tipo": tipo,
        "empresa": empresa,
        "placa": placa,
        "nombreCompleto": nombreCompleto,
        "cedula": cedula,
        "pasajero": pasajero,
        "calle": calle,
        "numero": numero,
        "observacion": observacion,
        "fecha": fecha.toIso8601String(),
        "evento": evento,
      };
}
