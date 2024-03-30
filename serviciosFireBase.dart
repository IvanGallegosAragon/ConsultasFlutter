import 'package:cloud_firestore/cloud_firestore.dart';

//Instancia FireBase
FirebaseFirestore db = FirebaseFirestore.instance;
//

//------------------------Agregar Usuario-----------------------------------
Future<void> addUser(String user) async {
  //Funcion de generar un usuario nuevo conforme al identificador en String del usuario
  //de la session actual
  //Inicialización de subcolección
  //Es una inicialización de campos vacios solo para que se genere el usuario sin campos
  final datos = <String, dynamic>{
    "monto": 0,
    "fecha": DateTime.now(),
  };
  //Subcoleccion de ingresos
  //!!!!!!!!!!!!!!CAMBIAR EL USUARIO AL ACTIVO
  final refIngresos =
      db.collection('users').doc(user).collection('ingresos').doc();
  //Generación de subcoleccion de ingresos
  refIngresos.set(datos);
  //Subcoleccion de egresos
  //!!!!!!!!!!!!!!CAMBIAR EL USUARIO AL ACTIVO
  final refEgresos =
      db.collection('users').doc(user).collection('egresos').doc();
  //Generación de subcoleccion de ingresos
  refEgresos.set(datos);

  //Generación de campo SALDO, este cambiara con cada ingreso y egreso
  final refUsuario = db.collection('users').doc(user);
  refUsuario.set({"saldo": 0});
}

//------------------------Agregar Ingreso-----------------------------------
Future<void> addIngreso(double monto, String user) async {
  //Agrega un ingreso conforme al monto y el identificador en String del usuario actual
  //así como atualizar el cambo saldo del usuario
  final transaccion = {
    "monto": monto,
    "fecha": DateTime.now(),
  };
  //Demo es el usuario cambialo por el user de autentication
  db.collection("users").doc(user).collection('ingresos').add(transaccion);
  //Actualizamos el saldo
  db.collection("users").doc(user).update(
    {"saldo": FieldValue.increment(monto)},
  );
}
//------------------------Agregar Egreso-----------------------------------

Future<void> addEgreso(double monto, String user) async {
  final transaccion = {
    "monto": monto,
    "fecha": DateTime.now(),
  };
  //Demo es el usuario cambialo por el user de autentication
  db.collection("users").doc(user).collection('egresos').add(transaccion);
  //Actualizamos el saldo
  //Parceamos
  db.collection("users").doc(user).update(
    {"saldo": FieldValue.increment(-monto)},
  );
}
//------------------------Consultas-----------------------------------
