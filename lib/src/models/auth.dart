import 'dart:convert';

Auth authFromMap(String str) => Auth.fromMap(json.decode(str));

String authToMap(Auth data) => json.encode(data.toMap());

class Auth {
  String token;
  DateTime expiracion;
  Auth({
    required this.token,
    required this.expiracion,
  });
  Auth copyWith({
    String? token,
    DateTime? expiracion,
  }) =>
      Auth(
        token: token ?? this.token,
        expiracion: expiracion ?? this.expiracion,
      );

  factory Auth.fromMap(Map<String, dynamic> json) => Auth(
        token: json["token"],
        expiracion: DateTime.parse(json["expiracion"]),
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "expiracion": expiracion.toIso8601String(),
      };
}
