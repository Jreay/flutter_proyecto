import 'dart:convert';
import 'dart:io';
import 'package:flutter_proyecto/src/models/actividad_post.dart';
import 'package:flutter_proyecto/src/models/registro.dart';
import 'package:http/http.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class HttpService {
  final String postsURL = "http://10.0.2.2:3000";

  Future<List<Actividad>> getPosts() async {
    Response res = await get(Uri.parse("$postsURL/"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['actividad'];

      List<Actividad> posts = body
        .map(
          (dynamic item) => Actividad.fromJson(item),
        )
        .toList();

      return posts;
    } else {
      throw "Error de conexion";
    }
  }

  Future<List<Registro>> getPostsLectura() async {
    Response res = await get(Uri.parse("$postsURL/lectura"));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['lectura'];

      List<Registro> posts = body
        .map(
          (dynamic item) => Registro.fromJson(item),
        )
        .toList();

      return posts;
    } else {
      throw "Error de conexion";
    }
  }

  Future<void> addPost(int id, String codigo, String titular, String direccion, String mz, String villa, String lectura, String localizacion, String urlcamera) async {
    Object map = {"id":"${id}","codigo":"${codigo}","titular":"${titular}","direccion":"${direccion}","mz":"${mz}","villa":"${villa}","lectura":"${lectura}","localizacion":"${localizacion}", "urlcamera":"${urlcamera}"};
    final res = await post(Uri.parse("$postsURL/lectura/add"),body: map);
    final rep = res.body;
    // final rep = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(rep);
    } else {
      throw "Error al guardar";
    }
    // print(map);
  }

  Future<void> updatePost(Actividad actividad) async {
    final res = await put(Uri.parse("$postsURL/update/${actividad.id}"),body:ActividadToJson(actividad));
    final rep = jsonDecode(res.body);
    if (res.statusCode == 200) {
      print(rep);
    } else {
      throw "Error al actualizar";
    }
  }

  // Future<String> subirImagen(File imagen) async {
  //   final url = Uri.parse("https://api.cloudinary.com/v1_1/dtrkd3yj8/image/upload?upload_preset=dsguqtjp");
  //   final mimeType = mime(imagen.path)!.split("/");

  //   final imagenResp = MultipartRequest("POST", url);
  //   final file = await MultipartFile.fromPath(
  //     "file", 
  //     imagen.path,
  //     contentType: MediaType( mimeType[0], mimeType[1])
  //   );
  //   imagenResp.files.add(file);
    
  //   final StreamedResponse = await imagenResp.send();
  //   final resp = await Response.fromStream(StreamedResponse);

  //   if(resp.statusCode != 200 && resp.statusCode != 201){
  //     print(resp.body);
  //     return "";
  //   }

  //   final respData = jsonDecode(resp.body);
  //   print(respData);

  //   return respData['secure_url'];

  // }
}
