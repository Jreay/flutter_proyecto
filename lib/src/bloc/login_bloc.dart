import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:observable/observable.dart';
import 'package:flutter_proyecto/src/bloc/validar.dart';

class LoginBloc with Validar {
  final _userController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<String>();

  Stream<String> get userStream => _userController.stream.transform(ValidarUser);
  Stream<String> get passStream => _passController.stream.transform(ValidarPass);

  // Stream<bool> get validarDatos => 
  //   Observable.combineLatest2(userStream, passStream, (e,p)=> true); 

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePass => _passController.sink.add;
  
  String get user => _userController.value;
  String get pass => _passController.value;

  dispose(){
    _userController.close();
    _passController.close();
  }

}