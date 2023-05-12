import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore BD = FirebaseFirestore.instance;

//--------------------------VEHICULO--------------------------

//Funcion para obtener la informacion que esta en la BD
  Future<List> getVehiculos() async{
  List vehiculo = [];
  CollectionReference collectionReferenceVehiculo  = BD.collection('vehiculo');
  //Consulta para obtener los datos de la coleccion
  QuerySnapshot queryVehiculo = await BD.collection('vehiculo').get();
  for (var doc in queryVehiculo.docs){
    final Map<String,dynamic>data = doc.data() as Map<String,dynamic>;
    final vehiculos = {
      "placa":data['placa'],
      "tipo":data['tipo'],
      "numeroserie":data['numeroserie'],
      "combustible":data['combustible'],
      "tanque":data['tanque'].toString(),
      "trabajador":data['trabajador'],
      "depto":data['depto'],
      "resguardadopor":data['resguardadopor'],
      "dID":doc.id,
    };
    vehiculo.add(vehiculos);
  }
  return vehiculo;
}

//Funcion para agregar Vehiculo
Future<void> addVehiculo(String placa,String tipo,
                          String numero,String combustible, int tanque,
                            String trabajador, String depto, String resguardado) async {

    await  BD.collection('vehiculo').add({"placa":placa,"tipo":tipo,"numeroserie":numero,
                                          "combustible":combustible,"tanque":tanque,"trabajador":trabajador,
                                          "depto":depto,"resguardadopor":resguardado});

}

//Funcion para actualizar Vehiculo
Future<void> updateVehiculo(String dID, String placa,String tipo,
                              String numero,String combustible, int tanque,
                                 String trabajador, String depto, String resguardado) async{
    
    await BD.collection('vehiculo').doc(dID).set({"placa":placa,"tipo":tipo,"numeroserie":numero,
                                                  "combustible":combustible,"tanque":tanque,"trabajador":trabajador,
                                                  "depto":depto,"resguardadopor":resguardado});
}

//Funcion para eliminar Vehiculo
Future<void> deleteVehiculo(String dID) async {
    await BD.collection('vehiculo').doc(dID).delete();
}

//--------------------------BITACORA--------------------------
//Funcion para obtener la informacion que esta en la BD
Future<List> getBitacoras() async{
  List bitacora = [];
  CollectionReference collectionReferenceBitacora  = BD.collection('bitacora');
  //Consulta para obtener los datos de la coleccion
  QuerySnapshot queryBitacora = await BD.collection('bitacora').get();
  for (var doc in queryBitacora.docs){
    final Map<String,dynamic>data = doc.data() as Map<String,dynamic>;
    final bitacoras = {
      "evento":data['evento'],
      "fecha":data['fecha'],
      "recursos":data['recursos'],
      "fechaverificiacion":data['fechaverificiacion'],
      "verifico":data['verifico'],
      "placa":data['placa'],
      "dID":doc.id,
    };
    bitacora.add(bitacoras);
  }
  return bitacora;
}

//Funcion para agregar Bitacora
Future<void> addBitacora(String evento,String fecha,
    String fechaverificiacion,String recursos, String verifico, String placa) async {

  await  BD.collection('bitacora').add({"evento":evento,"fecha":fecha,"fechaverificiacion":fechaverificiacion,
    "recursos":recursos,"verifico":verifico, "placa":placa});

}

//Funcion para actualizar Bitacora
Future<void> updateBitacora(String dID,String evento,String fecha,
    String fechaverificiacion,String recursos, String verifico, String placa) async{

  await BD.collection('bitacora').doc(dID).set({"evento":evento,"fecha":fecha,"fechaverificiacion":fechaverificiacion,
    "recursos":recursos,"verifico":verifico,"placa":placa});
}

//Funcion para eliminar Bitacora
Future<void> deleteBitacora(String dID) async {
  await BD.collection('bitacora').doc(dID).delete();
}


//---------------------Consultas-------------------------------------------


//Obtener todas las placas de los vehiculos
Future<List<String>> getPlacas() async {
  List<String> placas = [];
  QuerySnapshot querySnapshot = await BD.collection("vehiculo").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    placas.add(data['placa']);
  }
  return placas;
}

//Obtener todas las placas actuales en bitacora
Future<List<String>> getPlacasBitacora() async {
  List<String> placas = [];
  QuerySnapshot querySnapshot = await BD.collection("bitacora").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    placas.add(data['placa']);
  }
  return placas;
}

//Obtener placas mediante un where
Future<List<String>> getPlacasS(String d) async {
  List<String> placas = [];
  QuerySnapshot querySnapshot = await BD.collection("vehiculo").where("depto", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    placas.add(data['placa']);
  }
  return placas;
}

//Obtener Bitacora dependiendo la fecha
Future<List<Map<String, dynamic>>> getBitacoraFecha() async {
  List<Map<String, dynamic>> bitacorafecha = [];
  QuerySnapshot querySnapshot = await BD.collection("bitacora").where("fechaverificiacion", isEqualTo: "").get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacorafecha.add({'evento': data['evento'], 'fechaverificiacion': data['fechaverificiacion'],
      'placa': data['placa'],'recursos': data['recursos'],'verifico': data['verifico']});
  }
  return bitacorafecha;
}

//Consulta 1: consulta de bitacora (listado de todas las salidas o utilizaciones) de un vehículo por PLACA.
Future<List<Map<String, dynamic>>> getBitacoraPlaca(String placa) async {
  List<Map<String, dynamic>> bitacoraplaca = [];
  QuerySnapshot querySnapshot = await BD.collection("bitacora").where("placa", isEqualTo: placa).get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacoraplaca.add({'evento': data['evento'], 'fechaverificiacion': data['fechaverificiacion'],
      'placa': data['placa'],'recursos': data['recursos'],'verifico': data['verifico']});
  }
  return bitacoraplaca;
}

//Consulta 2: consulta de bitacora (listado de todas las salidas o utilizaciones) de todos los vehiculos segun fecha especifica.
Future<List<Map<String, dynamic>>> getBitacoraFechaE(String fecha) async {
  List<Map<String, dynamic>> bitacoraplaca = [];
  QuerySnapshot querySnapshot = await BD.collection("bitacora").where("fecha", isEqualTo: fecha).get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    bitacoraplaca.add({'evento': data['evento'], 'fechaverificiacion': data['fechaverificiacion'],
      'placa': data['placa'],'recursos': data['recursos'],'verifico': data['verifico']});
  }
  return bitacoraplaca;
}


//Consulta 4: Obtener Coches dependiendo el Departamento
Future<List<Map<String, dynamic>>> getVehiculosD(String d) async {
  List<Map<String, dynamic>> placasAndModelos = [];
  QuerySnapshot querySnapshot = await BD.collection("vehiculo").where("depto", isEqualTo: d).get();
  for (var docSnapshot in querySnapshot.docs) {
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    placasAndModelos.add({'placa': data['placa'], 'tipo': data['tipo'],
      'combustible': data['combustible'],'numeroserie': data['numeroserie'],'trabajador': data['trabajador'],
      'resguardadopor': data['resguardadopor']});
  }
  return placasAndModelos;
}

Future<List<Map<String,dynamic>>> consultaUno(String placa) async{
  List<Map<String, dynamic>> consulta = [];
  QuerySnapshot querySnapshot = await BD.collection("bitacora").where("placa", isEqualTo: placa).get();
  for(var docSnapshot in querySnapshot.docs){
    final Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
    consulta.add({"placa": data["placa"], "fecha": data["fecha"],
      "evento": data["evento"], "recursos": data["recursos"], "verifico": data["verifico"],
      "fechaverificacion": data["fechaverificacion"]
    });
  }
  return consulta;
}