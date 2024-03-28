import 'package:flutter/material.dart';
import 'vistas/consultFire.dart';
import 'vistas/addUserFire.dart';
import 'vistas/addIngresoFire.dart';
import 'vistas/addEgresoFire.dart';
import 'vistas/consultaFutureBuilder.dart';

class Navegador extends StatefulWidget {
  const Navegador({super.key});
  @override
  State<Navegador> createState() => _NavegadorState();
}

class _NavegadorState extends State<Navegador> {
  void _home(int n) {
    setState(() {
      _indice = n;
    });
  }

  @override
  void initState() {
    super.initState();
    _cuerpo.add(const ConsultFire(
      title: "Fire",
    ));
    _cuerpo.add(const AddFire(
      title: "Fire",
    ));
    _cuerpo.add(const AddIngresoFire(
      title: "Fire",
    ));
    _cuerpo.add(const AddEgresosFire(
      title: "Fire",
    ));
    _cuerpo.add(const ConsultFB(
      title: "Fire",
    ));
  }

  int _indice = 0;
  final _cuerpo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cuerpo[_indice],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indice,
        onTap: (value) {
          setState(() {
            _indice = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.square),
            label: 'Consultas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_rounded),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: 'Ingreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subdirectory_arrow_left),
            label: 'Gastp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label),
            label: 'FutureList',
          ),
        ],
      ),
    );
  }
}
