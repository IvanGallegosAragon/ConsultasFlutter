import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFire extends StatefulWidget {
  const AddFire({super.key, required this.title});
  final String title;
  @override
  State<AddFire> createState() => _AddFireState();
}

class _AddFireState extends State<AddFire> {
  //------------------------------------------------------------------------------------------------------
  //Instancia del DB
  FirebaseFirestore db = FirebaseFirestore.instance;

  //FUncion para agregar usuario generando campos de tranascción
  Future<void> addUser() async {
    //Inicialización de subcolección
    //Es una inicialización de campos vacios solo para que se genere el usuario sin campos
    final datos = <String, dynamic>{
      "monto": 0,
      "fecha": DateTime.now(),
    };
    //Subcoleccion de ingresos
    //!!!!!!!!!!!!!!CAMBIAR EL USUARIO AL ACTIVO
    final refIngresos =
        db.collection('users').doc('demo').collection('ingresos').doc();
    //Generación de subcoleccion de ingresos
    refIngresos.set(datos);
    //Subcoleccion de egresos
    //!!!!!!!!!!!!!!CAMBIAR EL USUARIO AL ACTIVO
    final refEgresos =
        db.collection('users').doc('demo').collection('egresos').doc();
    //Generación de subcoleccion de ingresos
    refEgresos.set(datos);

    //Generación de campo SALDO, este cambiara con cada ingreso y egreso
    final refUsuario = db.collection('users').doc('demo');
    refUsuario.set({"saldo": 0});
  }
  //------------------------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                addUser();
              },
              child: const Text('Nuevo Usuario'))
        ],
      ),
    );
  }
}
