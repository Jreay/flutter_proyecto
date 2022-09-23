import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proyecto/services/http_service.dart';
import 'package:flutter_proyecto/src/models/registro.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({Key? key}) : super(key: key);
  State<NewRegister> createState() => _NewRegister();
}

class _NewRegister extends State<NewRegister> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Registro _registro = Registro(
      id: 0,
      codigo: '',
      titular: '',
      direccion: '',
      mz: '',
      villa: '',
      lectura: '',
      localizacion: '',
      urlcamera: '');

  final HttpService httpService = HttpService();
  File? foto;
  bool _guardando = false;
  String? ruta;

  TextEditingController code = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController v = TextEditingController();
  TextEditingController lect = TextEditingController();
  TextEditingController gps = TextEditingController();
  TextEditingController camera = TextEditingController();
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

  //ocr
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = "";

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // final Registro? prodData = ModalRoute.of(context)?.settings.arguments as Registro?;
    // if ( prodData != null ) {
    //   _registro = prodData;
    // }
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
                        _wubicacion(),
                        const SizedBox(
                          height: 20,
                        ),
                        if (textScanning) const CircularProgressIndicator(),
                        if (!textScanning && imageFile == null)
                          Container(
                            width: 300,
                            height: 300,
                            color: Colors.grey[300]!,
                          ),
                        if (imageFile != null)
                          Image.file(File(imageFile!.path)),
                          
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.grey,
                                    shadowColor: Colors.grey[400],
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  onPressed: () {
                                    getImage(ImageSource.gallery);
                                    
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 30,
                                        ),
                                        Text(
                                          "Gallery",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    onPrimary: Colors.grey,
                                    shadowColor: Colors.grey[400],
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                  ),
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.camera_alt,
                                          size: 30,
                                        ),
                                        Text(
                                          "Camera",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey[600]),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   child: Text(
                        //     ruta!,
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        _wlectura(),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton.icon(
                          onPressed: () async {
                            ruta = await httpService.subirImagen(imageFile!) as String?;
                          },
                          icon: Icon(Icons.cloud_queue_sharp, size: 18),
                          label: Text("Cargar URL"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (ruta != null)
                        _wurl(),
                        const SizedBox(
                          height: 20,
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            httpService.addPost(
                                -1,
                                code.text,
                                title.text,
                                address.text,
                                m.text,
                                v.text,
                                "$scannedText",
                                "Long: $long  Lat: $lat",
                                "$ruta");                           
                            // _onSubmit(context);
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
        controller: TextEditingController(text: '$ruta'),
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
          enabled: false,
          //border: InputBorder.none,
          hintText: "Ingrese Lectura",
        ),
        controller: TextEditingController(text: '$scannedText'),
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
}
