import 'package:flutter/material.dart';
import 'package:flutter_proyecto/services/http_service.dart';
import 'package:flutter_proyecto/src/models/registro.dart';
import 'package:flutter_proyecto/src/pages/view_lectura.dart';
import 'package:flutter_proyecto/src/pages/view_registrer.dart';

class ListRegisters extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina Lectura"),
      ),
      body: FutureBuilder(
        future: httpService.getPostsLectura(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Registro>> snapshot) {
          if (snapshot.hasData) {
            List<Registro> posts = snapshot.data!;
            return ListView(
              children: posts
                  .map(
                    (Registro post) => Card(
                      child: Column(
                        children: [
                            ListTile(
                              title: Text("Vivienda: " + post.codigo),
                              trailing: Column(children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.blueAccent,
                                    size: 36.0,
                                  ),
                              ]),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://cdn0.iconfinder.com/data/icons/houses-blue-line/64/131_house-home-check-mark-ok-512.png"),
                              ),
                              subtitle: Text("${post.direccion}  MZ ${post.mz}  SL ${post.villa}"),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViemLectura(
                                    post: post,
                                  ),
                                ),
                              ),
                            )
                          ] 
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
