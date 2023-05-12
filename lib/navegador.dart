import 'package:dam_u3_vehiculos_firebase/Bitacora/bitacora.dart';
import 'package:dam_u3_vehiculos_firebase/Querys/consultas.dart';
import 'package:dam_u3_vehiculos_firebase/Vehiculo/inicio.dart';
import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class Navegador extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Navegador();
  }
}

class _Navegador extends State<Navegador>{
  int _indice = 0;

  void _cambiarIndice(int indice){
    setState(() {
      _indice = indice;
    });
  }

  final List<Widget> _pagina = [
    InicioV(),
    Consultas(),
    InicioB(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagina[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.car_rental_outlined), label: "Vehiculo"),
          BottomNavigationBarItem(icon: Icon(Icons.content_paste_search), label: "Consultas"),
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda), label: "Bitacora")
        ],
        currentIndex: _indice,
        showUnselectedLabels: false,
        iconSize: 30,
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        onTap: _cambiarIndice,

      ),
    );
  }

}