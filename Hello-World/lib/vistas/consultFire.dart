import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ConsultFire extends StatefulWidget {
  const ConsultFire({super.key, required this.title});
  final String title;
  @override
  State<ConsultFire> createState() => _ConsultFireState();
}

class _ConsultFireState extends State<ConsultFire> {
//------------------------------------------------------------------------------------
//
//Instancia del DB
  FirebaseFirestore db = FirebaseFirestore.instance;

//Consulta ingresos desde siempre
//Lista que contiene elementos  de todos los ingresos realizados por el usuario
//los elementos de la lista esta dividido como (Fecha,Monto,ColorRandom)
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
//
  Future<List> consultaIngresosSiempre() async {
    List ingresosSiempre = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef.collection("ingresos").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ingresosSiempre.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(ingresosSiempre);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return ingresosSiempre;
  }

//Lista que contiene elementos  de todos los gastos realizados por el usuario
// esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaEgresosSiempre() async {
    List gastosSiempre = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef.collection("egresos").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          gastosSiempre.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(gastosSiempre);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return gastosSiempre;
  }

  //Consulta de Ingresos totales del usuario en todo el tiempo
  //Es un valor double? devuelve la suma de todos los ingresos exitentes en
  //la subcoleccion de ingresos
  //El ? a lado del doble es un condicionante de existencia
  Future<double?> consultaIngresosTotales() async {
    double? monto = 0;
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("ingresos")
        .aggregate(sum('monto'))
        .get()
        .then((AggregateQuerySnapshot aggregateSnapshot) {
      //En vez de print usa return para obtener el valor si quieres guardalo en un Double
      monto = aggregateSnapshot.getSum('monto');
      print(monto);
    });

    return monto;
  }

  //Consulta de Egresos totales del usuario en todo el tiempo
  //Es un valor double? devuelve la suma de todos los egresos exitentes en
  //la subcoleccion de egresos
  //El ? a lado del doble es un condicionante de existencia
  Future<double?> consultaEgresosTotales() async {
    double? monto = 0;
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("egresos")
        .aggregate(sum('monto'))
        .get()
        .then((AggregateQuerySnapshot aggregateSnapshot) {
      //En vez de print usa return para obtener el valor si quieres guardalo en un Double
      monto = aggregateSnapshot.getSum('monto');
      print(monto);
    });
    return monto;
  }

  //Consulta ingresos del dia actual del usuario
  ////el Char Data esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaIngresosDelDia() async {
    DateTime dia =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List ingresosDelDia = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("egresos")
        .where('fecha', isGreaterThanOrEqualTo: dia)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ingresosDelDia.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(ingresosDelDia);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return ingresosDelDia;
  }

  //Consulta gastos del dia del usuario
  ////el Char Data esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaEgresosDelDia() async {
    DateTime dia =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    List gastosDelDia = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("egresos")
        .where('fecha', isGreaterThanOrEqualTo: dia)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          gastosDelDia.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(gastosDelDia);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return gastosDelDia;
  }

  //Consulta gastos del mes del usuario
  ////el Char Data esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaEgresosDelMes() async {
    DateTime mes = DateTime(DateTime.now().year, DateTime.now().month);
    List gastosDelMes = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("egresos")
        .where('fecha', isGreaterThanOrEqualTo: mes)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          gastosDelMes.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(gastosDelMes);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return gastosDelMes;
  }

  //Consulta ingresos del mes
  ////el Char Data esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaIngresosDelMes() async {
    DateTime mes = DateTime(DateTime.now().year, DateTime.now().month);
    List ingresosDelMes = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("ingresos")
        .where('fecha', isGreaterThanOrEqualTo: mes)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ingresosDelMes.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(ingresosDelMes);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return ingresosDelMes;
  }

  //Consulta ingresos del año
  ////el Char Data esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaIngresosDelYear() async {
    DateTime year = DateTime(DateTime.now().year);
    List ingresosDelYear = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("ingresos")
        .where('fecha', isGreaterThanOrEqualTo: year)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          ingresosDelYear.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(ingresosDelYear);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return ingresosDelYear;
  }

  //Consulta egresos del año del usuario
  ////el Char Data esta dividido como (Fecha,Monto,ColorRandom)
//La Decha esta como un DateTime así que al momento de usarlo cortalo a conveniencia
//usalo en una lista o una lista? (el ? es algoa sí de existencia)
//Elimina el Print en producción
  Future<List> consultaEngresosDelYear() async {
    DateTime year = DateTime(DateTime.now().year);
    List gastosDelYear = [];
    //Cambia el usuario demo por el usuario actual
    final userRef = db.collection('users').doc('demo');
    userRef
        .collection("egresos")
        .where('fecha', isGreaterThanOrEqualTo: year)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          gastosDelYear.add((
            docSnapshot.data()['fecha'].toDate(),
            docSnapshot.data()['monto'],
            Colors.primaries[Random().nextInt(Colors.primaries.length)]
          ));
        }
        print(gastosDelYear);
      },
      onError: (e) => print("Error completing: $e"),
    );
    return gastosDelYear;
  }

//-------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                consultaIngresosSiempre();
              },
              child: const Text('Consulta'))
        ],
      ),
    );
  }
}
