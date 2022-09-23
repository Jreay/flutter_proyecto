import 'package:flutter/material.dart';
import 'package:flutter_proyecto/services/http_service.dart';
import 'package:flutter_proyecto/src/models/actividad_post.dart';
import 'package:flutter_proyecto/src/models/registro.dart';


class ViemLectura extends StatelessWidget {
  final Registro post;
  final HttpService httpService = HttpService();


  ViemLectura({required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle vivienda"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text("Código"),
                      subtitle: Text(post.codigo),
                    ),
                    ListTile(
                      title: Text("Titular"),
                      subtitle: Text(post.titular),
                    ),
                    ListTile(
                      title: Text("Dirección"),
                      subtitle: Text("${post.direccion} MZ ${post.mz} SL ${post.villa}"),
                    ),
                    ListTile(
                      title: Text("Ubicación"),
                      subtitle: Text("${post.localizacion}"),
                    ),
                    ListTile(
                      title: Text("Lectura"),
                      subtitle: Text("${post.lectura}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}