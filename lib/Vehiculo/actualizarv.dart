import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class ActualizarV extends StatefulWidget {
  const ActualizarV({Key? key}) : super(key: key);

  @override
  State<ActualizarV> createState() => _ActualizarVState();
}


String ElegidoT= "";

List Departamento = ["Sistemas","Administracion","Materiales","Jardineria",
  "Direccion","Seguridad","Mantenimiento"];
String ElegidoD= "";


String _Departamento = Departamento.first;

List TipoCoche = ["Camion","Coche","Camioneta","Tracktor","Motocicleta","Barco","Avion"];


String _Tipo = TipoCoche.first;



class _ActualizarVState extends State<ActualizarV> {



  TextEditingController placaC = TextEditingController(text: "");
  TextEditingController tipoC = TextEditingController(text: "");
  TextEditingController numeroserieC = TextEditingController(text: "");
  TextEditingController combustibleC = TextEditingController(text: "");
  TextEditingController tanqueC = TextEditingController(text: "");
  TextEditingController trabajadorC = TextEditingController(text: "");
  TextEditingController resguardadoC = TextEditingController(text: "");
  TextEditingController departamentoC = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {



    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    placaC.text = arguments['placa'];
    numeroserieC.text = arguments['numeroserie'];
    combustibleC.text = arguments['combustible'];
    trabajadorC.text = arguments['trabajador'];
    resguardadoC.text = arguments['resguardadopor'];
    tanqueC.text = arguments['tanque'];
    tipoC.text = arguments['tipo'];
    departamentoC.text = arguments['depto'];

    String _Tipo = arguments['tipo'].toString();
    String C ="";



    return Scaffold(
      appBar: AppBar(title: Text("ACTUALIZAR VEHICULO",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true,backgroundColor: Colors.blueGrey),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(decoration: InputDecoration(labelText: "PLACA",
              icon: Icon(Icons.card_membership,color: Colors.indigo,)),controller: placaC,autofocus: true,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "TIPO VEHICULO",
              icon: Icon(Icons.car_repair,color: Colors.indigo)),controller: tipoC,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "NUMERO SERIE",
              icon: Icon(Icons.confirmation_num_outlined,color: Colors.indigo)),controller: numeroserieC,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "COMBUSTIBLE",
              icon: Icon(Icons.local_gas_station_outlined,color: Colors.indigo)),controller: combustibleC,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "TANQUE",
              icon: Icon(Icons.propane_tank,color: Colors.indigo)),controller: tanqueC,keyboardType: TextInputType.number),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "TRABAJADOR",
              icon: Icon(Icons.personal_injury,color: Colors.indigo)),controller: trabajadorC,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "DEPARTAMENTO",
              icon: Icon(Icons.home_work_outlined,color: Colors.indigo)),controller: departamentoC,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "RESGUARDADO",
              icon: Icon(Icons.security,color: Colors.indigo)),controller: resguardadoC,),
          SizedBox(height: 10),

          ElevatedButton(onPressed: () async {
              await updateVehiculo(arguments['dID'], placaC.text, tipoC.text, numeroserieC.text,
                                    combustibleC.text, int.parse(tanqueC.text) ,
                                    trabajadorC.text, departamentoC.text, resguardadoC.text).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("VEHICULO ACTUALIZADO"))
                );
                Navigator.pop(context);
              });
          }, child: Text("Actualizar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
          ),)
        ],


    ));
  }
}
