import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ActualizarB extends StatefulWidget {
  const ActualizarB({Key? key}) : super(key: key);

  @override
  State<ActualizarB> createState() => _ActualizarBState();
}


class _ActualizarBState extends State<ActualizarB> {



  TextEditingController verificoC = TextEditingController(text: "");
  TextEditingController eventoC = TextEditingController(text: "");
  TextEditingController recursosC = TextEditingController(text: "");
  TextEditingController fechaC = TextEditingController(text: "");
  TextEditingController fechaverificiacionC = TextEditingController(text: "");
  TextEditingController placaC = TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {



    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    verificoC.text = arguments['verifico'];
    eventoC.text = arguments['evento'];
    recursosC.text = arguments['recursos'];
    fechaC.text = arguments['fecha'];
    fechaverificiacionC.text = arguments['fechaverificiacion'];
    placaC.text = arguments['placa'];


    return Scaffold(
      appBar: AppBar(title: Text("ACTUALIZAR BITACORA",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true,backgroundColor: Colors.blueGrey),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
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
            child: Text(
              'POR SEGURIDAD ALGUNOS CAMPOS ESTAN BLOQUEADOS',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "EVENTO",
              icon: Icon(Icons.carpenter,color: Colors.indigo),enabled: false,),controller: eventoC,autofocus: true,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "FECHA",
              icon: Icon(Icons.calendar_month_outlined,color: Colors.indigo,),enabled: false,),controller: fechaC,),
          SizedBox(height: 10),
          TextField(decoration: InputDecoration(labelText: "RECURSOS",
              icon: Icon(Icons.article_rounded,color: Colors.indigo),enabled: false,),controller: recursosC,),
          TextField(decoration: InputDecoration(labelText: "PLACA",
              icon: Icon(Icons.card_membership,color: Colors.indigo)),enabled: false,controller: placaC,),
          ElevatedButton(onPressed: () async {
              await updateBitacora(arguments['dID'], eventoC.text, fechaC.text, fechaverificiacionC.text,
                  recursosC.text, verificoC.text,placaC.text).then((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("BITACORA ACTUALIZADA"))
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
