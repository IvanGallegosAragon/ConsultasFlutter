import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ConsultFB extends StatefulWidget {
  const ConsultFB({super.key, required this.title});
  final String title;
  @override
  State<ConsultFB> createState() => _ConsultFBState();
}

class _ConsultFBState extends State<ConsultFB> {
//Instancia del DB
  FirebaseFirestore db = FirebaseFirestore.instance;

//Consulta ingresos desde siempre
//Lista que contiene elementos  de todos los ingresos realizados por el usuario
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaIngresosSiempre() async {
    //Lista de importancia
    List ingresosSiempre = [];
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("ingresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference.get();

    for (var document in queryIngresos.docs) {
      ingresosSiempre.add(document.data());
    }
    return ingresosSiempre;
  }

//Consulta egresos desde siempre
//Lista que contiene elementos  de todos los egresos realizados por el usuario
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaEgresosSiempre() async {
    //Lista de importancia
    List egresosSiempre = [];
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("egresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference.get();

    for (var document in queryIngresos.docs) {
      egresosSiempre.add(document.data());
    }
    return egresosSiempre;
  }

  //Consulta de Ingresos totales del usuario en todo el tiempo
  //Es una lista devuelve la suma de todos los ingresos exitentes en
  //la subcoleccion de ingresos
  //Si puedes cambiarlo a un solo double, mejor.
  Future<List> consultaIngresosTotales() async {
    List monto = [];
    //Cambia el usuario demo por el usuario actual
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("ingresos");

    AggregateQuerySnapshot aggregateQuerySnapshotSum =
        await collectionReference.aggregate(sum('monto')).get();
    monto.add(aggregateQuerySnapshotSum.getSum('monto'));
    return monto;
  }

  //Consulta de Ingresos totales del usuario en todo el tiempo
  //Es una lista devuelve la suma de todos los ingresos exitentes en
  //la subcoleccion de ingresos
  //Si puedes cambiarlo a un solo double, mejor.
  Future<List> consultaEgresosTotales() async {
    List monto = [];
    //Cambia el usuario demo por el usuario actual
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("egresos");

    AggregateQuerySnapshot aggregateQuerySnapshotSum =
        await collectionReference.aggregate(sum('monto')).get();
    monto.add(aggregateQuerySnapshotSum.getSum('monto'));
    return monto;
  }

//Consulta Ingresos del dia
//Lista que contiene elementos  de todos los ingresos realizados por el usuario
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaIngresosDelDia() async {
    //Lista de importancia
    List ingresosDelDia = [];
    DateTime dia =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("ingresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference
        .where('fecha', isGreaterThanOrEqualTo: dia)
        .get();

    for (var document in queryIngresos.docs) {
      ingresosDelDia.add(document.data());
    }
    return ingresosDelDia;
  }

//Consulta Egresos del dia
//Lista que contiene elementos  de todos los egresos realizados por el usuario
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaEgresosDelDia() async {
    //Lista de importancia
    List egresosDelDia = [];
    DateTime dia =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("egresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference
        .where('fecha', isGreaterThanOrEqualTo: dia)
        .get();

    for (var document in queryIngresos.docs) {
      egresosDelDia.add(document.data());
    }
    return egresosDelDia;
  }

//Consulta Egresos del mes
//Lista que contiene elementos  de todos los egresos realizados por el usuario durante el mes
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaEgresosDelMes() async {
    //Lista de importancia
    List egresosDelMes = [];
    DateTime mes = DateTime(DateTime.now().year, DateTime.now().month);
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("egresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference
        .where('fecha', isGreaterThanOrEqualTo: mes)
        .get();

    for (var document in queryIngresos.docs) {
      egresosDelMes.add(document.data());
    }
    return egresosDelMes;
  }

//Consulta Ingresos del mes
//Lista que contiene elementos  de todos los egresos realizados por el usuario durante el mes
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaIngresosDelMes() async {
    //Lista de importancia
    List ingresosDelMes = [];
    DateTime mes = DateTime(DateTime.now().year, DateTime.now().month);
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("ingresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference
        .where('fecha', isGreaterThanOrEqualTo: mes)
        .get();

    for (var document in queryIngresos.docs) {
      ingresosDelMes.add(document.data());
    }
    return ingresosDelMes;
  }

//Consulta Ingresos del año
//Lista que contiene elementos  de todos los egresos realizados por el usuario durante el año
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaIngresosDelyear() async {
    //Lista de importancia
    List ingresosDelMes = [];
    DateTime ano = DateTime(DateTime.now().year);
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("ingresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference
        .where('fecha', isGreaterThanOrEqualTo: ano)
        .get();

    for (var document in queryIngresos.docs) {
      ingresosDelMes.add(document.data());
    }
    return ingresosDelMes;
  }

//Consulta Ingresos del año
//Lista que contiene elementos  de todos los egresos realizados por el usuario durante el año
//La Date esta como un DateTime así que al momento de usarlo cortalo a conveniencia
  Future<List> consultaEgresosDelyear() async {
    //Lista de importancia
    List egresosDelMes = [];
    DateTime ano = DateTime(DateTime.now().year);
    //Refrencia a la colección
    CollectionReference collectionReference =
        db.collection('users').doc('demo').collection("egresos");
    //consulta
    QuerySnapshot queryIngresos = await collectionReference
        .where('fecha', isGreaterThanOrEqualTo: ano)
        .get();

    for (var document in queryIngresos.docs) {
      egresosDelMes.add(document.data());
    }
    return egresosDelMes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //El FutureBuilder hace uso de una argumento future que recibe una lista dinamica futura
      //y lo guarda en el snapshot del builder, el builder lo que ara es regresar un Widget que
      //utilize los valores del snapshot
      //se genera un snapshot.hasData para que si no tiene datos en la espera de la consulta
      //mande un ciruclo de carga y cuando reciba la consulta se realize los necesario
      body: FutureBuilder(
        future: consultaEgresosDelyear(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  //Solo para visualización si el leng es solo uno o cero
                  // se muestra el valor de las
                  //consultas de agregación como las sumas o nada si no hay consultas como
                  //las del dia en caso de que no haya ingresos o egresos el dia de hoy
                  //si es mayor significa que son documentos
                  if ((snapshot.data?.length) == (1 | 0)) {
                    return Text((snapshot.data?[index]).toString());
                  } else {
                    return Text((
                      snapshot.data?[index]['fecha'].toDate(),
                      snapshot.data?[index]['monto'],
                      Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    )
                        .toString());
                  }
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
