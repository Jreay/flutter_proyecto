import 'package:flutter/material.dart';
import 'package:flutter_proyecto/src/pages/home_page.dart';
import 'package:flutter_proyecto/src/pages/login_page.dart';
import 'package:flutter_proyecto/src/pages/new_register_page.dart';
import 'package:flutter_proyecto/src/pages/list_registers_page.dart';

class Routes extends StatelessWidget {
  final int index; 
  const Routes({super.key, required this.index});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      HomePage(),
      ListRegisters(),
      const NewRegister(),
      const LoginPage()
    
    ];
    return myList[index];
  }
}