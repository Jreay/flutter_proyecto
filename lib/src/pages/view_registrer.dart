

import 'package:flutter/material.dart';
import 'package:flutter_proyecto/services/http_service.dart';
import 'package:flutter_proyecto/src/models/actividad_post.dart';


class ViemHome extends StatelessWidget {
  final Actividad post;
  final HttpService httpService = HttpService();


  ViemHome({required this.post});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle Actividad Vivienda"),
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
                      title: Text("Actividad"),
                      subtitle: Text(post.actividad),
                    ),
                    ListTile(
                      title: Text("Estado"),
                      subtitle: Text("${post.estado}"),
                    ),
                    // Row(
                    //         children: [
                    //           OutlinedButton.icon(
                    //             onPressed: () {
                    //               httpService.updatePost(post.id, "${post.codigo}", "${post.titular}", "${post.direccion}", "${post.mz}", "${post.villa}", "${post.actividad}", "revisado");
                    //               // Navigator.pop(context);
                    //             },
                    //             icon: Icon(Icons.check, size: 18),
                    //             label: Text("Revisado"),
                                
                                
                    //           ),
                    //           // Expanded(
                    //           //   child: Container(
                    //           //     child: Center( ),
                    //           //   ),
                    //           // ),
                    //           OutlinedButton.icon(
                    //             onPressed:() => {
                    //               httpService.updatePost(post.id, "${post.codigo}", "${post.titular}", "${post.direccion}", "${post.mz}", "${post.villa}", "${post.actividad}", "rechazado"),
                    //               // Navigator.pop(context)
                    //             },
                    //             icon: Icon(Icons.close, size: 18),
                    //             label: Text("Rechazado"),
                    //           ),
                    //         ],
                    //       ),
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