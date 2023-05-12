import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class InicioB extends StatefulWidget {
  const InicioB({Key? key}) : super(key: key);

  @override
  State<InicioB> createState() => _InicioBState();
}

class _InicioBState extends State<InicioB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BITACORA"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: FutureBuilder(
          future: getBitacoras(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (builder) {
                          return AlertDialog(
                            title: Text("ATENCION"),
                            content: Text(
                              "¿QUÉ DESEA HACER CON LA BITACORA DEL EVENTO: \n${snapshot.data?[index]['evento']}?",
                              textAlign: TextAlign.center,),
                            actions: [
                              TextButton(onPressed: () async {
                                Navigator.pop(context);
                                await Navigator.pushNamed(
                                    context, '/updateB', arguments: {
                                  "dID": snapshot.data?[index]['dID'],
                                  "evento": snapshot.data?[index]['evento'],
                                  "fecha": snapshot.data?[index]['fecha'],
                                  "fechaverificiacion": snapshot.data?[index]['fechaverificiacion'],
                                  "recursos": snapshot.data?[index]['recursos'],
                                  "verifico": snapshot.data?[index]['verifico'],
                                  "placa":snapshot.data?[index]['placa']
                                });
                                setState(() {});
                              }, child: Text("ACTUALIZAR")),
                              TextButton(onPressed: () async {},
                                  child: const Text("NADA")),
                            ],
                          );
                        });
                      },
                      child:
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                            children: [
                              ListTile(
                                leading: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(Icons.calendar_month_outlined, color: Colors.indigo),
                                    SizedBox(height: 3.0),
                                    Text("Fecha:\n"+snapshot.data?[index]['fecha'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                  ],
                                ),
                                title: Text(snapshot.data?[index]['evento']+" ["+snapshot.data?[index]['placa']+"]",
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                subtitle: Text("Recursos: "+snapshot.data?[index]['recursos']),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(height: 3.0),
                                    Text("Verificado:\n"+snapshot.data?[index]['fechaverificiacion'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                    Icon(Icons.calendar_month_outlined, color: Colors.indigo)
                                  ],
                                ),
                              ),
                              Divider(height: 20,thickness: 2, color: Colors.blue),
                            ],
                        )
                      )
                    );
                  }
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/addB');
            setState(() {});
          },
          child: Icon(Icons.add), backgroundColor: Colors.black,
        )
    );
  }}