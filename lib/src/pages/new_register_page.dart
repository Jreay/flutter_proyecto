
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proyecto/services/http_service.dart';
import 'package:flutter_proyecto/src/models/registro.dart';
import 'package:flutter_proyecto/src/pages/list_registers_page.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({Key? key}) : super(key: key);
  State<NewRegister> createState() => _NewRegister();
}

class _NewRegister extends State<NewRegister> {
  final _formKey     = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Registro _registro = Registro(id: 0, codigo: '', titular: '', direccion: '', mz: '', villa: '', lectura: '', localizacion: '', urlcamera: '');

  final HttpService httpService = HttpService();
  File? foto;
  bool _guardando = false;

  TextEditingController code = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController v = TextEditingController();
  TextEditingController lect = TextEditingController();
  TextEditingController gps = TextEditingController();
  TextEditingController camera = TextEditingController();

  // final Registro _registro = Registro(
  //     id: 0,
  //     codigo: "",
  //     titular: "",
  //     direccion: "",
  //     mz: "",
  //     villa: "",
  //     lectura: "",
  //     localizacion: "",
  //     urlcamera: "");
  // final List<Registro> _registros = [];
  // final _formKey = GlobalKey<FormState>();
  // final _scaffoldkey = GlobalKey<ScaffoldState>();
  // final _codigo = TextEditingController(text: '');
  // final _titular = TextEditingController(text: '');
  // final _direccion = TextEditingController(text: '');
  // final _mz = TextEditingController(text: '');
  // final _villa = TextEditingController(text: '');
  // final _lectura = TextEditingController(text: '');
  // final _localizacion = TextEditingController(text: '');
  // final _urlcamera = TextEditingController(text: '');
  final String titulo = "Nuevo Registro";

  void _okSmartAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Mensaje del Sistema'),
        content: const Text('Registro Almacenado con éxito'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: const Text('Listo'),
          ),
        ],
      ),
    );
  }

  _onSubmit(BuildContext context) async {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();




    // if(!_formKey.currentState!.validate()) return;
// ignore: avoid_print
    // _formKey.currentState!.save();
      print('''
      codigo : ${_registro.codigo}
      titular : ${_registro.titular}
      direccion : ${_registro.direccion}
      mz: ${_registro.mz}
      villa: ${_registro.villa}
      lectura: ${_registro.lectura}
      localizacion: ${_registro.localizacion}
      urlcamera: ${_registro.urlcamera}
      ''');

      // httpService.addPost(Registro(
      //     id: -1,
      //     codigo: _registro.codigo,
      //     titular: _registro.titular,
      //     direccion: _registro.direccion,
      //     mz: _registro.mz,
      //     villa: _registro.villa,
      //     lectura: _registro.lectura,
      //     localizacion: _registro.localizacion,
      //     urlcamera: _registro.urlcamera));

      form.reset();

      _okSmartAlert(context);
    }
  }

  //location
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // print(position.longitude); //Output: 80.24599079
    // print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      // print(position.longitude); //Output: 80.24599079
      // print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final Registro? prodData = ModalRoute.of(context)?.settings.arguments as Registro?;
    if ( prodData != null ) {
      _registro = prodData;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    // padding: const EdgeInsets.all(25),
                    padding: const EdgeInsets.only(
                      left: 35,
                      right: 35.0,
                    ),

                      child: Column(
                        children: <Widget>[
                          // _mostrarFoto(),
                          _wcode(),
                          _wtitular(),
                          _wadress(),
                          _wmz(),
                          _wvilla(),
                          _wlectura(),
                          _wubicacion(),
                          _wurl(),

                          // ElevatedButton(
                          //   onPressed: () => _onSubmit(context),
                          //   child: const Text("Guardar"),
                          // ),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () => _tomarFoto(),
                                icon: Icon(Icons.camera, size: 18),
                                label: Text("Foto"),
                              ),
                              Expanded(
                                child: Container(
                                  child: Center( ),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed:() => _seleccionarFoto(),
                                icon: Icon(Icons.image, size: 18),
                                label: Text("Galeria"),
                              ),
                            ],
                          ),

                          OutlinedButton.icon(
                            onPressed: ()  {
                              // _onSubmit(context);
                              httpService.addPost(-1, code.text, title.text, address.text, m.text , v.text, lect.text, "Long: $long  Lat: $lat", camera.text);
                            },
                            icon: Icon(Icons.save, size: 18),
                            label: Text("Guardar"),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   child: Container(height: 40.0),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(_registros.length);
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => ListRegisters(registros: _registros),
      //       ),
      //     );
      //   },
      //   tooltip: 'Increment Counter',
      //   child: const Icon(Icons.list),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  } // build

  _wcode() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        ],
        decoration: const InputDecoration(
          labelText: "Codigo de Vivienda",
          icon: Icon(Icons.home),
          //border: InputBorder.none,
          hintText: "Ingrese Código",
        ),
        controller: code,
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingresa el codigo";
          } else if (value.length > 5) {
            return "Codigo no valido solo 5 numeros";
          } else {
            return null;
          }
        },
        onSaved: (value) => _registro.codigo = value!,
      );

  _wtitular() => TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Titular",
          icon: Icon(Icons.person),
          hintText: "Ingrese Nombre",
        ),
        controller: title,
        // maxLength: 30,
        onSaved: (val) => _registro.titular = val!,
        validator: (val) => (val!.isEmpty ? 'Por favor ingresa nombre' : null),
      );

  _wadress() => TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            labelText: "Dirección",
            icon: Icon(Icons.map_outlined),
            //border: InputBorder.none,
            hintText: "Ingrese Dirección"),
        controller: address,
        // maxLength: 50,
        onSaved: (val) => _registro.direccion = val!,
        validator: (val) =>
            (val!.isEmpty ? 'Por favor ingresa dirreción' : null),
      );

  _wmz() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        ],
        decoration: const InputDecoration(
          labelText: "Manzana",
          icon: Icon(Icons.approval),
          //border: InputBorder.none,
          hintText: "Ingrese Manzana",
        ),
        controller: m,
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingresa manzana";
          } else if (value.length > 2) {
            return "Codigo no valido solo 2 numeros";
          } else {
            return null;
          }
        },
        onSaved: (value) => _registro.mz = value!,
      );

  _wvilla() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        ],
        decoration: const InputDecoration(
          labelText: "Villa",
          icon: Icon(Icons.approval),
          //border: InputBorder.none,
          hintText: "Ingrese Villa",
        ),
        controller: v,
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingresa villa";
          } else if (value.length > 2) {
            return "Codigo no valido solo 2 numeros";
          } else {
            return null;
          }
        },
        onSaved: (value) => _registro.villa = value!,
      );

  _wubicacion() => TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            labelText: "Ubicaion",
            icon: Icon(Icons.my_location_sharp),
            enabled: false,
            //border: InputBorder.none,
            hintText: ""),
        controller: TextEditingController(text: 'Long: $long  Lat: $lat'),
        onSaved: (val) => _registro.localizacion = val!,
        validator: (val) =>
            (val!.isEmpty ? 'Por favor ingresa dirreción' : null),
      );

  _wurl() => TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
            labelText: "Url Imagen",
            icon: Icon(Icons.image_search_sharp),
            // enabled: false,
            //border: InputBorder.none,
            hintText: "Tomar/Subir Foto"),
        controller: camera,
        onSaved: (val) => _registro.urlcamera = val!,
        validator: (val) => (val!.isEmpty ? 'Por favor ingresa foto' : null),
      );

  _wlectura() => TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
        ],
        decoration: const InputDecoration(
          labelText: "Lectura",
          icon: Icon(Icons.numbers_outlined),
          //border: InputBorder.none,
          hintText: "Ingrese Lectura",
        ),
        controller: lect,
        validator: (value) {
          if (value!.isEmpty) {
            return "Por favor ingresa Lectura";
          } else if (value.length > 5) {
            return "Codigo no valido solo 5 numeros";
          } else {
            return null;
          }
        },
        onSaved: (value) => _registro.lectura = value!,
      );

  Widget _mostrarFoto(){
    if( _registro.urlcamera != null){
      return FadeInImage(
        image: NetworkImage( _registro.urlcamera ),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    }else{
      return Image(
        image: AssetImage( foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
        );
    }
  }

  _seleccionarFoto() async {
    _procesarFoto( ImageSource.gallery);
  }

  _tomarFoto() async{
     _procesarFoto( ImageSource.camera);
  }

  _procesarFoto( ImageSource ruta) {
    final pick = ImagePicker();
    foto = pick.pickImage( source: ruta) as File? ;

    if( foto != null){
      // _registro.urlcamera = httpService.subirImagen(foto!) as String;
    }else{
    }
    setState(() { });
  }

}

