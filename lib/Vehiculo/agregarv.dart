import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class AgregarVehiculo extends StatefulWidget {
  const AgregarVehiculo({Key? key}) : super(key: key);

  @override
  State<AgregarVehiculo> createState() => _AgregarVehiculoState();
}

List TipoCoche = ["Camion","Coche","Camioneta","Tracktor","Motocicleta","Barco","Avion"];
List Gasolina = ["Gasolina low cost","Gasolina normal","Gasolina premium","Diesel"];
String ElegidoT= "";

List Departamento = ["Sistemas","Administracion","Materiales","Jardineria",
                      "Direccion","Seguridad","Mantenimiento"];
String ElegidoD= "";

  final placaC = TextEditingController();
  final tipoC = TextEditingController();
  final numeroserieC = TextEditingController();
  final combustibleC = TextEditingController();
  final tanqueC = TextEditingController();
  final trabajadorC = TextEditingController();
  final resguardadoC = TextEditingController();
  final departamentoC = TextEditingController();

  String _Tipo = TipoCoche.first;
  String _Departamento = Departamento.first;
  String _Gasolina = Gasolina.first;



class _AgregarVehiculoState extends State<AgregarVehiculo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AGREGAR VEHICULO",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true,backgroundColor: Colors.blueGrey),
      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(decoration: InputDecoration(labelText: "PLACA",
                icon: Icon(Icons.card_membership,color: Colors.indigo)),controller: placaC,autofocus: true,),
            SizedBox(height: 25),
           Text("TIPO DE VEHICULO",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
            SizedBox(height: 25),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: "ELIGE UN VEHICULO",border: OutlineInputBorder()),
                icon: Icon(Icons.car_repair,color: Colors.indigo),
                value: _Tipo,
                items: TipoCoche.map((valor){
                  return DropdownMenuItem(child: Text(valor),value: valor);
                }).toList(),
                onChanged: (valor){
                  setState(() {
                    _Tipo = valor.toString();
                  });
                }
            ),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "NUMERO SERIE",
              icon: Icon(Icons.confirmation_num_outlined,color: Colors.indigo,)),controller: numeroserieC,),
            SizedBox(height: 25),
            Text("TIPO DE COMBUSTIBLE",textAlign: TextAlign.center,style: TextStyle(fontSize: 16),),
            SizedBox(height: 25),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: "ELIGE COMBUSTIBLE",border: OutlineInputBorder()),
                icon: Icon(Icons.local_gas_station_outlined,color: Colors.indigo),
                value: _Gasolina,
                items: Gasolina.map((valor){
                  return DropdownMenuItem(child: Text(valor),value: valor);
                }).toList(),
                onChanged: (valor){
                  setState(() {
                    _Gasolina = valor.toString();
                  });
                }
            ),
            TextField(decoration: InputDecoration(labelText: "TANQUE",
                icon: Icon(Icons.propane_tank,color: Colors.indigo)),controller: tanqueC,keyboardType: TextInputType.number,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "TRABAJADOR",
                icon: Icon(Icons.personal_injury,color: Colors.indigo)),controller: trabajadorC,),
            SizedBox(height: 25),
            Text("DEPARTAMENTO",textAlign: TextAlign.center,style: TextStyle(fontSize: 16)),
            SizedBox(height: 25),
            DropdownButtonFormField(
                decoration: InputDecoration(labelText: "ELIGE UN DEPARTAMENTO",border: OutlineInputBorder()),
                icon: Icon(Icons.home_work_outlined,color: Colors.indigo),
                value: _Departamento,
                items: Departamento.map((valor){
                  return DropdownMenuItem(child: Text(valor),value: valor);
                }).toList(),
                onChanged: (valor){
                  setState(() {
                    _Departamento = valor.toString();
                  });
                }
            ),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "RESGUARDADO POR",
                icon: Icon(Icons.security,color: Colors.indigo)),controller: resguardadoC,),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () async {
              addVehiculo(placaC.text, _Tipo.toString(), numeroserieC.text, _Gasolina.toString(),
                  int.parse(tanqueC.text) , trabajadorC.text, _Departamento.toString(),
                  resguardadoC.text).then((_){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("VEHICULO AGREGADO"))
                );
                placaC.text ="";
                numeroserieC.text="";
                combustibleC.text="";
                tanqueC.text="";
                trabajadorC.text="";
                departamentoC.text="";
                resguardadoC.text="";
                Navigator.pop(context);
              });
            }, child: Text("Agregar",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
            ),)
          ]
      ),
    );
  }
}
