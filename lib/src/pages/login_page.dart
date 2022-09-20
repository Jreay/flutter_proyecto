import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/src/bloc/provider.dart';
import 'package:flutter_proyecto/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _fondo(context),
          _login(context),
        ],
      ),
    );
  }

  Widget _login(BuildContext context) {

      final bloc = Provider.of(context);
      final size = MediaQuery.of(context).size;
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                height: 250.0,
              ),
              
            ),

            Container(
              width: size.width * 0.80,
              margin: EdgeInsets.symmetric(vertical: 30.0),
              padding: EdgeInsets.symmetric(vertical: 50.0),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0
                  )
                ]
              ),
              child: Column(
                children: <Widget>[
                  Text("Iniciar Sesión", style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 40.0 ),
                  _User(bloc),
                  SizedBox(height: 20.0 ),
                  _Pass(bloc),
                  SizedBox(height: 40.0 ),
                  _Boton(context),
                ],
              ),
            ),
            SizedBox(height: 100.0)
          ],
        ),
      );
  }
  
   
  Widget _Boton(BuildContext context){
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text("Ingresar"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0) 
        ),
        elevation: 0.0,
        color: Colors.cyan,
        textColor: Colors.white,
        onPressed: (){
           Navigator.pushNamed(context, "paginas");
          // _logen(LoginBloc blocLogin, BuildContext context){
          // print("user: ${blocLogin.user}");
          // print("pass: ${blocLogin.pass}");

          // Navigator.pushReplacementNamed(context, "home");
        //  }
          }
    );

    
  }
 

  
  

  Widget _Pass(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.cyan),
                labelText: "Contraseña",
                counterText: snapshot.data,
                errorText: snapshot.error?.toString()
              ),
              onChanged: bloc.changePass,
            ),
          );
        });
  }

  Widget _User( LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.userStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),

          child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.person, color:Colors.cyan),
            hintText: "Ingrese Ususario",
            labelText: "Usuario",
            counterText: snapshot.data,
            errorText: snapshot.error?.toString()
          ),
          onChanged: bloc.changeUser,
          ),
        ); 
      }
    );
  }

  Widget _fondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final _fondoCian = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromARGB(255, 16, 236, 244),
            Color.fromARGB(255, 151, 241, 235),
          ],
        ),
      ),
    );

    final decorador = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), 
          color: Colors.white54),
    );

    return Stack(
      children: <Widget>[
        _fondoCian,
        Positioned(top: 90.0, left: 30.0, child: decorador),
        Positioned(top: -40.0, right: -30.0, child: decorador),
        Positioned(top: -40.0, left: -30.0, child: decorador),
        Positioned(bottom: -50.0, right: -10.0, child: decorador),
        Positioned(bottom: 120.0, right: 20.0, child: decorador),
        Positioned(bottom: -50.0, left: -20.0, child: decorador),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.system_security_update_good_rounded, color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                "Plataformas Móviles",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
