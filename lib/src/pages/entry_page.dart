import 'package:flutter/material.dart';
import 'package:fringreso/src/widgets/input_decorations.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Ingreso'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: _submitQr,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              children: [
                _FormEntry(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitQr() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#3D8BEF',
      'Cancelar',
      false,
      ScanMode.QR,
    );

    print(barcodeScanRes);
  }
}

class _FormEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            _espacio(
              DropdownButtonFormField(
                items: [].map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.descripcion),
                    value: item.id,
                  );
                }).toList(),
                value: 2,
                onSaved: (value) => print(value),
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Tipo Ingreso',
                ),
                onChanged: (id) {},
              ),
            ),
            _espacio(
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      // initialValue: 'ASD-123',
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Placa',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => print(value.trim()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Text('Placa'),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          tooltip: 'Foto Placa',
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            _espacio(
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Empresa',
                ),
                keyboardType: TextInputType.text,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor ingrese un texto'
                    : null,
                onChanged: (value) => print(value.trim()),
              ),
            ),
            _espacio(
              DropdownButtonFormField<String>(
                  items: ['si', 'no']
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
                  // value: _opcionPasajero,
                  onSaved: (value) => print(value),
                  decoration: InputDecorations.authInputDecoration(
                    labelText: 'Pasajero',
                  ),
                  onChanged: (opt) => print(opt)),
            ),
            _espacio(
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Cedula Identidad',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => print(value.trim()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      children: [
                        Text('C.I.'),
                        IconButton(
                          icon: const Icon(Icons.camera_alt),
                          tooltip: 'Foto C.I.',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _espacio(
              TextFormField(
                // initialValue: initialValue,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Calle',
                ),
                keyboardType: TextInputType.text,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor ingrese un texto'
                    : null,
                onChanged: (value) => print(value.trim()),
              ),
            ),
            _espacio(
              TextFormField(
                // initialValue: initialValue,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Número',
                ),
                keyboardType: TextInputType.text,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor ingrese un texto'
                    : null,
                onChanged: (value) => print(value.trim()),
              ),
            ),
            _espacio(
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Observación',
                ),
                keyboardType: TextInputType.text,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Por favor ingrese un texto'
                    : null,
                onChanged: (value) => print(value.trim()),
              ),
            ),
            _espacio(
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.red,
                child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 120,
                      //vertical: 15,
                    ),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _espacio(Widget child) {
    return Column(
      children: [
        SizedBox(
          height: 6.0,
        ),
        Divider(),
        child
      ],
    );
  }
}
