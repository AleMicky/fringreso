import 'package:flutter/material.dart';
import 'package:fringreso/src/models/ingreso.dart';
import 'package:fringreso/src/providers/ingresar_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final headlines = Provider.of<IngresarProvider>(context).headlines;
    return Scaffold(
      body: _ListarIngreso(headlines),
    );
  }
}

class _ListarIngreso extends StatelessWidget {
  final List<Ingreso> ingreso;
  const _ListarIngreso(this.ingreso);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.ingreso.length,
      itemBuilder: (BuildContext context, int index) {
        return _Ingreso(
          ingreso: this.ingreso[index],
          index: index,
        );
      },
    );
  }
}

class _Ingreso extends StatelessWidget {
  final Ingreso ingreso;
  final int index;
  _Ingreso({
    required this.ingreso,
    required this.index,
  });

  final f = new DateFormat('yyyy/MM/dd');
  final h = new DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('${ingreso.tipo} Codigo: ${ingreso.placa} '),
            subtitle: Text(
                'Fecha: ${f.format(ingreso.fecha)} Hora: ${h.format(ingreso.fecha)}'), // Text('${ingreso.fecha}'),
          ),
        ],
      ),
    );
  }
}
