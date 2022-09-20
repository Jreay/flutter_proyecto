import 'package:flutter/material.dart';
import 'package:flutter_proyecto/src/bloc/provider.dart';
import 'package:flutter_proyecto/src/pages/home_page.dart';
import 'package:flutter_proyecto/src/pages/login_page.dart';
import 'package:flutter_proyecto/src/pages/new_register_page.dart';
import 'package:flutter_proyecto/src/pages/pagina.dart';
import 'package:flutter_proyecto/src/pages/list_registers_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        initialRoute: "login",
        routes: {        
          "login":(context) => LoginPage(),
          "home":(context) => HomePage(),
          "new":(context) => NewRegister(),
          "list":(context) => ListRegisters(),
          // "paginas":(context) => Principal(),
        },        
        //no trabaja en modo desarrollo
        debugShowCheckedModeBanner: false,       
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
      )  
    ); 
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_proyecto/src/navbar/nav_bar.dart';
// import 'package:flutter_proyecto/src/navbar/routes.dart';
// import 'package:flutter_proyecto/src/pages/home_page.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: Principal(),
//     );
//   }
// }

