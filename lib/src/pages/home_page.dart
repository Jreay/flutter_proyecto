import 'package:flutter/material.dart';
import 'package:flutter_proyecto/services/http_service.dart';
import 'package:flutter_proyecto/src/models/actividad_post.dart';
import 'package:flutter_proyecto/src/pages/view_registrer.dart';

class HomePage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina Principal"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Actividad>> snapshot) {
          if (snapshot.hasData) {
            List<Actividad> posts = snapshot.data!;
            return ListView(
              children: posts
                  .map(
                    (Actividad post) => Card(
                      child: Column(
                        children: [
                          if ("${post.estado}" != "pendiente") ...[
                            ListTile(
                              title: Text("Vivienda: " + post.codigo),
                              trailing: Column(children: [
                                if ("${post.estado}" == "revisado") ...[
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 36.0,
                                  ),
                                ] else ...[
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 36.0,
                                  ),
                                ]
                              ]),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://mdphomes.net/assets/blog/images/home.png"),
                              ),
                              subtitle: Text("${post.direccion}  MZ ${post.mz}  SL ${post.villa}"),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViemHome(
                                    post: post,
                                  ),
                                ),
                              ),
                            )
                          ] else ...[
                            ListTile(
                              title: Text("Vivienda: " + post.codigo),
                              trailing: Column(
                                children: [
                                  Icon(
                                    Icons.remove_circle,
                                    color: Colors.orange.shade700,
                                    size: 36.0,
                                  ),
                                ],
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://mdphomes.net/assets/blog/images/home.png"),
                              ),
                              subtitle: Text("${post.direccion}  MZ ${post.mz}  SL ${post.villa}"),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViemHome(
                                    post: post,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
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
