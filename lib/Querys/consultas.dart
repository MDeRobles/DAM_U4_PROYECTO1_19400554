import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Consultas extends StatefulWidget {
  const Consultas({Key? key}) : super(key: key);

  @override
  State<Consultas> createState() => _ConsultasState();
}

List Departamento = ["Sistemas","Administracion","Materiales","Jardineria",
  "Direccion","Seguridad","Mantenimiento"];

String _Departamento = Departamento.first;
final placaC = TextEditingController();
final fechaC = TextEditingController();

class _ConsultasState extends State<Consultas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CONSULTAS",style: TextStyle(fontWeight: FontWeight.bold)),centerTitle: true,backgroundColor: Colors.blueGrey),
      body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 10),
            Text("Consulta de bitacora:  \n\nListado de todas las salidas o utilizaciones de un vehículo por \nPLACA.",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
            Text("\n\nPLACAS REGISTRADAS ACTUALMENTE",style: TextStyle(fontSize: 19),textAlign: TextAlign.center),
            SizedBox(height: 4),
            FutureBuilder<List<String>>(
              future: getPlacasBitacora(),
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                return Text(snapshot.data.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20),);
              },
            ),
            TextField(decoration: InputDecoration(labelText: "ESCRIBE UNA DE LAS PLACAS ANTERIORES",
                icon: Icon(Icons.card_membership,color: Colors.indigo)),controller: placaC,),
            SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getBitacoraPlaca(placaC.text),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('\nEvento: ${snapshot.data![index]['evento']} \n Fecha: ${snapshot.data![index]['fecha']} '
                              '\n Recursos: ${snapshot.data![index]['recursos' ]} \n Verificado por: ${snapshot.data![index]['verifico' ]} ',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Loading...');
                }
                },
                ),
            ElevatedButton(onPressed: () async {
              setState(() {
                placaC.text;
              });
            }, child: Text("Consultar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),),



            Divider(height: 50,thickness: 2, color: Colors.blue),
            Text("Consulta de bitacora:  \n\nListado de todas las salidas o utilizaciones de todos los vehículos según una fecha específica",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getBitacoraFechaE(fechaC.text),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '\nEvento: ${snapshot.data![index]['evento']} \n Fecha Verificacion: ${snapshot.data![index]['fechaverificiacion']} '
                              '\n Recursos: ${snapshot.data![index]['recursos' ]} \n Verificado por: ${snapshot.data![index]['verifico' ]} ',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Loading...');
                }
              },
            ),
            ElevatedButton(onPressed: () async {
              setState(() {
                fechaC.text;
              });
            }, child: Text("Consultar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),),


            Divider(height: 50,thickness: 2, color: Colors.blue),
            Text("Consulta de vehículos: \n\nVehiculos que estén en uso o fuera de la institución (fecha de verificación vacía)",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            Divider(height: 50,thickness: 2, color: Colors.blue),
            Text("Consulta de vehículos: \n\nVehiculos asignados a X departamento",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getVehiculosD(_Departamento),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 120,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          '\nPlaca: ${snapshot.data![index]['placa']} \n Tipo: ${snapshot.data![index]['tipo']} '
                              '\n Combustible: ${snapshot.data![index]['combustible']} \n Numero de Serie: ${snapshot.data![index]['numeroserie']} '
                              '\n Trabajador: ${snapshot.data![index]['trabajador' ]} \n Resguardado por: ${snapshot.data![index]['resguardadopor' ]} ',
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Loading...');
                }
              },
            ),




            TextField(decoration: InputDecoration(labelText: "Inserte placa a buscar",),
              controller: placaC,),

            SizedBox(height: 50,),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: consultaUno(placaC.text),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
                if(snapshot.hasData){
                  return
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index){
                            return
                              Text("Placas: ${snapshot.data![index]["placa"]}"
                                  "\n Fecha:  ${snapshot.data![index]["fecha"]}"
                                  "\n Recursos: ${snapshot.data![index]["recursos"]}"
                                  "\n Verificado por: ${snapshot.data![index]["verifico"]}"
                              );


                          }

                      ),
                    );
                } else if(snapshot.hasError){
                  return Text("error: ${snapshot.error}");
                } else{
                  return Text("Loading...");
                }


              } ,

            ),
            ElevatedButton(onPressed: () async {
              setState(() {
                placaC.text;
              });
            }, child: Text("Consultar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),),

          ]
    ),
    );
  }
}
