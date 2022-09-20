
import 'dart:async';

class Validar{

  final ValidarUser = StreamTransformer<String, String>.fromHandlers(
    handleData: (user, sink){


      if(user == "admin" ){
        sink.add(user);
      }else{
        sink.addError("Usuario no valido");
      }

    }
  );
  // ignore: non_constant_identifier_names
  final ValidarPass = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink){

      if(pass == "123" ){
        sink.add("");
      }else{
        sink.addError("Máximo de 3 caracteres");
      }

    }
  );

}

