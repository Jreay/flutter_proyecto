import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/src/navbar/nav_bar.dart';
import 'package:flutter_proyecto/src/navbar/routes.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int index = 0;
  Paginas ?pagina;

  @override
  void initState() {
    pagina = Paginas(currentIndex: (i){
      setState(() {
        index = i;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: pagina,
      body: Routes(index: index),
    );
  }
}