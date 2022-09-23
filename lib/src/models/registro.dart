// To parse this JSON data, do
//
//     final registro = registroFromJson(jsonString);

import 'dart:convert';

Registro registroFromJson(String str) => Registro.fromJson(json.decode(str));

String registroToJson(Registro data) => json.encode(data.toJson());

class Registro {

     int id;
     String codigo;
    String titular;
    String direccion;
    String mz;
    String villa;
    String lectura;
    String localizacion;
    String urlcamera;
    Registro({
         required this.id,
         required this.codigo,
         required this.titular,
         required this.direccion,
         required this.mz,
         required this.villa,
         required this.lectura,
         required this.localizacion,
         required this.urlcamera,
    });

    

    factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        id: json["id"],
        codigo: json["codigo"],
        titular: json["titular"],
        direccion: json["direccion"],
        mz: json["mz"],
        villa: json["villa"],
        lectura: json["lectura"],
        localizacion: json["localizacion"],
        urlcamera: json["urlcamera"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "titular": titular,
        "direccion": direccion,
        "mz": mz,
        "villa": villa,
        "lectura": lectura,
        "localizacion": localizacion,
        "urlcamera": urlcamera,
    };
}


// class Registro {
// int id;
// String codigo;
// String titular;
// String direccion;
// String mz;
// String villa;
// String localizacion;
// int lectura;

// Registro({
// required this.id,
// required this.codigo,
// required this.titular,
// required this.direccion,
// required this.mz,
// required this.villa,
// required this.localizacion,
// required this.lectura,
// });
// }