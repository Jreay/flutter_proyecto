import "package:flutter/material.dart";
import 'package:flutter_proyecto/src/bloc/login_bloc.dart';
export 'package:flutter_proyecto/src/bloc/login_bloc.dart';


class Provider extends InheritedWidget{

  // static Provider _instancia;

  // factory Provider({Key? key, required Widget child}){
  //   if(_instancia == null){
  //     _instancia = Provider._interno(key: key, child: child);
  //   }
  //   return _instancia;
  // }

  final loginBloc =LoginBloc();

  Provider({Key? key, required Widget child}) : super(key: key, child: child);


  @override 
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return ( context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).loginBloc;
  }

}