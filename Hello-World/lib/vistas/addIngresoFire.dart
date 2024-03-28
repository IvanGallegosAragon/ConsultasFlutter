import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddIngresoFire extends StatefulWidget {
  const AddIngresoFire({super.key, required this.title});
  final String title;
  @override
  State<AddIngresoFire> createState() => _AddIngresoFireState();
}

class _AddIngresoFireState extends State<AddIngresoFire> {
  //Instancia del DB
  FirebaseFirestore db = FirebaseFirestore.instance;

  //FUncion para agregar ingreso
  //Lo que realiza la función es realizar un nuevo doc de la subcollecion
  //ingresos ademas al finalizar dicha escritura actualiza el campo saldo del
  //usuario
  //!!!!!!!!!!!!!CAMBIAR EL USUARIO
  Future<void> addIngrso(double monto) async {
    final transaccion = {
      "monto": monto,
      "fecha": DateTime.now(),
    };
    //Demo es el usuario cambialo por el user de autentication
    db.collection("users").doc("demo").collection('ingresos').add(transaccion);
    //Actualizamos el saldo
    db.collection("users").doc("demo").update(
      {"saldo": FieldValue.increment(monto)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                addIngrso(500);
              },
              child: const Text('Nuevo Ingreso'))
        ],
      ),
    );
  }
}
