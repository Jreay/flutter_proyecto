import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Paginas extends StatefulWidget {
  final Function currentIndex;
  const Paginas({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<Paginas> createState() => _Paginas();
}

class _Paginas extends State<Paginas> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color:Colors.cyan
            ),
            label: 'Actividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt,color:Colors.cyan),
            label: 'lecturas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_outlined,color:Colors.cyan),
            label: 'Nuevo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_power,color:Colors.cyan),
            label: 'Salir',
          ),
        ],
        currentIndex: index,
        selectedItemColor: Colors.cyan[800],
        onTap: (int i){
          setState(() {
            index= i;
            widget.currentIndex(i);
          });
        },
      );
  }
}
