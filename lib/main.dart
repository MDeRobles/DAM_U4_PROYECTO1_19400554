import 'package:dam_u3_vehiculos_firebase/Bitacora/actualizarb.dart';
import 'package:dam_u3_vehiculos_firebase/Bitacora/agregarb.dart';
import 'package:dam_u3_vehiculos_firebase/Vehiculo/actualizarv.dart';
import 'package:dam_u3_vehiculos_firebase/Vehiculo/agregarv.dart';
import 'package:dam_u3_vehiculos_firebase/navegador.dart';
import 'package:flutter/material.dart';

//Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navegador(),
      routes: {
        '/add':(context) => const AgregarVehiculo(),
        '/update':(context) => const ActualizarV(),
        '/addB':(context) => const AgregarBitacora(),
        '/updateB':(context) => const ActualizarB(),
      },
    );
  }
}

