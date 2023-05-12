import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AgregarBitacora extends StatefulWidget {
  const AgregarBitacora({Key? key}) : super(key: key);

  @override
  State<AgregarBitacora> createState() => _AgregarBitacoraState();

}

  final eventoC = TextEditingController();
  final fechaC = TextEditingController();
  final fechaverificiacionC = TextEditingController();
  final recursosC = TextEditingController();
  final verificoC = TextEditingController();
  final placaC = TextEditingController();




class _AgregarBitacoraState extends State<AgregarBitacora> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AGREGAR BITACORA",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true,backgroundColor: Colors.blueGrey),
      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            TextField(decoration: InputDecoration(labelText: "EVENTO",
                icon: Icon(Icons.carpenter,color: Colors.indigo)),controller: eventoC,autofocus: true,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "FECHA",
              icon: Icon(Icons.calendar_month_outlined,color: Colors.indigo,)),onTap: (){
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900),
                maxTime: DateTime.now(),
                onConfirm: (date) {
                  final formattedDate = DateFormat('dd/MM/yyyy').format(date);
                  fechaC.text = formattedDate;
                },
                currentTime: DateTime.now(),
                locale: LocaleType.es,
              );
            },controller: fechaC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "RECURSOS",
              icon: Icon(Icons.article_rounded,color: Colors.indigo)),controller: recursosC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "VERIFICADO POR",
                icon: Icon(Icons.person,color: Colors.indigo)),controller: verificoC,),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "FECHA DE VERIFICACION",
                icon: Icon(Icons.calendar_month_outlined,color: Colors.indigo)),onTap: (){
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                minTime: DateTime(1900),
                maxTime: DateTime.now(),
                onConfirm: (date) {
                  final formattedDate = DateFormat('dd/MM/yyyy').format(date);
                  fechaverificiacionC.text = formattedDate;
                },
                currentTime: DateTime.now(),
                locale: LocaleType.es,
              );
            },controller: fechaverificiacionC,),
    SizedBox(height: 10),
    Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child:
    Text("PLACAS REGISTRADAS ACTUALMENTE",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),),
    SizedBox(height: 20),
            FutureBuilder<List<String>>(
              future: getPlacas(),
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  return Text(snapshot.data.toString(),textAlign: TextAlign.center,);
              },
            ),
            SizedBox(height: 20),
            TextField(decoration: InputDecoration(labelText: "ESCRIBE UNA DE LAS PLACAS ANTERIORES",
                icon: Icon(Icons.card_membership,color: Colors.indigo)),controller: placaC,autofocus: true,),
              ElevatedButton(onPressed: () async {
              addBitacora(eventoC.text, fechaC.text, fechaverificiacionC.text, recursosC.text, verificoC.text, placaC.text).then((_){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("BITACORA AGREGADA"))
                );
                eventoC.text ="";
                fechaC.text="";
                fechaverificiacionC.text="";
                verificoC.text="";
                recursosC.text="";
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
