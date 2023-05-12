
import 'package:dam_u3_vehiculos_firebase/servicios/firebase_servicios.dart';
import 'package:flutter/material.dart';

class InicioV extends StatefulWidget {
  const InicioV({Key? key}) : super(key: key);

  @override
  State<InicioV> createState() => _InicioVState();
}

class _InicioVState extends State<InicioV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("VEHICULOS"),centerTitle: true,backgroundColor: Colors.blueGrey,
        ),
        body: FutureBuilder(
          future: getVehiculos(),
          builder: ((context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (builder) {
                          return AlertDialog(
                            title: Text("ATENCION"),
                            content: Text("¿QUÉ DESEA HACER CON EL VEHICULO DEL TRABAJADOR: \n${snapshot.data?[index]['trabajador']}?",
                              textAlign: TextAlign.center,),
                            actions: [
                              TextButton(onPressed: () async {
                                Navigator.pop(context);
                                await   Navigator.pushNamed(context, '/update',arguments: {
                                  "dID": snapshot.data?[index]['dID'],
                                  "tipo": snapshot.data?[index]['tipo'],
                                  "placa": snapshot.data?[index]['placa'],
                                  "numeroserie":snapshot.data?[index]['numeroserie'],
                                  "combustible":snapshot.data?[index]['combustible'],
                                  "tanque":snapshot.data?[index]['tanque'].toString(),
                                  "trabajador":snapshot.data?[index]['trabajador'],
                                  "depto":snapshot.data?[index]['depto'],
                                  "resguardadopor":snapshot.data?[index]['resguardadopor']
                                });
                                setState(() {});
                              }, child: Text("ACTUALIZAR")),
                              TextButton(onPressed: () async {
                                        await deleteVehiculo(snapshot.data?[index]['dID']).then((_) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("VEHICULO ELIMINADO"))
                                          );
                                          setState(() {});
                                          Navigator.pop(context);
                                        });
                              }, child: const Text("BORRAR")),
                              TextButton(onPressed: () async {
                              }, child: const Text("NADA")),
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
                                  Icon(Icons.car_repair,color: Colors.indigo),
                                  SizedBox(height: 4.0),
                                  Text("Tipo:\n"+snapshot.data?[index]['tipo'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center,),
                                ],
                              ),
                              title: Text(snapshot.data?[index]['trabajador'],
                                style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Text("Dpto: "+snapshot.data?[index]['depto']),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height: 4.0),
                                  Text("Placas: \n"+snapshot.data?[index]['placa'],style: TextStyle(fontSize: 10),textAlign: TextAlign.center),
                                  Icon(Icons.card_membership,color: Colors.indigo)
                                ],
                              ),
                            ),
                            Divider(height: 20,thickness: 2, color: Colors.blue),
                          ],
                        ),

                      )

                    );
                  }
              );
            }else{
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () async{
              await Navigator.pushNamed(context, '/add');
              setState(() {});
          },
          child: Icon(Icons.add),backgroundColor: Colors.black,
        )
    );
  }


}