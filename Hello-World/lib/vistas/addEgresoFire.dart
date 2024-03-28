import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEgresosFire extends StatefulWidget {
  const AddEgresosFire({super.key, required this.title});
  final String title;
  @override
  State<AddEgresosFire> createState() => _AddEgresosFireState();
}

class _AddEgresosFireState extends State<AddEgresosFire> {
  //Instancia del DB
  FirebaseFirestore db = FirebaseFirestore.instance;

  //FUncion para agregar Egresos
  //Lo que realiza la función es realizar un nuevo doc de la subcollecion
  //Egresos ademas al finalizar dicha escritura actualiza el campo saldo del
  //usuario
  //!!!!!!!!!!!!!CAMBIAR EL USUARIO
  Future<void> addEgreso(double monto) async {
    final transaccion = {
      "monto": monto,
      "fecha": DateTime.now(),
    };
    //Demo es el usuario cambialo por el user de autentication
    db.collection("users").doc("demo").collection('egresos').add(transaccion);
    //Actualizamos el saldo
    //Parceamos
    db.collection("users").doc("demo").update(
      {"saldo": FieldValue.increment(-monto)},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                //Se le resta ek monto de 500
                addEgreso(500);
              },
              child: const Text('Nuevo Egreso'))
        ],
      ),
    );
  }
}
