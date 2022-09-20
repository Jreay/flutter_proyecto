import 'dart:convert';

import 'package:flutter/foundation.dart';

String ActividadToJson(Actividad data) => json.encode(data.toJson());

class Actividad {
  final int id;
  final String codigo;
  final String titular;
  final String direccion;
  final String mz;
  final String villa;
  final String actividad;
  String estado;

  Actividad({
    required this.id,
    required this.codigo,
    required this.titular,
    required this.direccion,
    required this.mz,
    required this.villa,
    required this.actividad,
    required this.estado,
  });

  factory Actividad.fromJson(Map<String, dynamic> json) {
    return Actividad(
      id: json['id'] as int,
      codigo: json['codigo'] as String,
      titular: json['titular'] as String,
      direccion: json['direccion'] as String,
      mz: json['mz'] as String,
      villa: json['villa'] as String,
      actividad: json['actividad'] as String,
      estado: json['estado'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        // "id": id,
        "codigo": codigo,
        "titular": titular,
        "direccion": direccion,
        "mz": mz,
        "villa": villa,
        "actividad": actividad,
        "estado": estado,
    };
}