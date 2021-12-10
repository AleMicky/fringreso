import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fringreso/src/models/tipoIngreso.dart';
import 'package:fringreso/src/providers/entry_form_provider.dart';
import 'package:fringreso/src/providers/ingresar_provider.dart';
import 'package:provider/provider.dart';
import 'package:fringreso/src/providers/tipo_ingreso_provider.dart';
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
            onPressed: () {
              _showDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Column(
              children: [
                ChangeNotifierProvider(
                  create: (_) => EntryFormProvider(),
                  child: _FormEntry(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Buscar por Cedula/Placa'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Codigo',
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('BUSCAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
    final headlines = Provider.of<TipoIngresoProvider>(context).headlines;
    final entryForm = Provider.of<EntryFormProvider>(context);

    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: entryForm.formKey,
        child: Column(
          children: [
            _espacio(
              DropdownButtonFormField(
                items: headlines.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item.descripcion),
                    value: item.id,
                  );
                }).toList(),
                //  value: 2,
                onSaved: (value) => print(value),
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Tipo Ingreso',
                ),
                onChanged: (id) {
                  TipoIngreso tipo =
                      headlines.firstWhere((tipo) => tipo.id == id);
                  entryForm.iniciarEvento(tipo);
                },
              ),
            ),
            entryForm.placaBool
                ? _espacio(
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecorations.authInputDecoration(
                              labelText: 'Placa',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Por favor ingrese un texto'
                                    : null,
                            onChanged: (value) =>
                                entryForm.placa = value.trim(),
                          ),
                        ),
                        entryForm.fotoPlaca
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Column(
                                  children: [
                                    Text('Placa'),
                                    IconButton(
                                      icon: const Icon(Icons.camera_alt),
                                      tooltip: 'Foto Placa',
                                      onPressed: () async {
                                        final ImagePicker picker =
                                            ImagePicker();
                                        final XFile? pickedFile =
                                            await picker.pickImage(
                                                source: ImageSource.camera,
                                                imageQuality: 100);
                                        if (pickedFile == null) {
                                          print('No seleciono nada');
                                          return;
                                        }
                                        print(
                                            'tenemos imagen ${pickedFile.path}');
                                      },
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            entryForm.empresaBool
                ? _espacio(
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Empresa',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => entryForm.empresa = value.trim(),
                    ),
                  )
                : Container(),
            entryForm.pasajeroBool
                ? _espacio(
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
                  )
                : Container(),
            entryForm.cedulaBool
                ? _espacio(
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecorations.authInputDecoration(
                              labelText: 'Cedula Identidad',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Por favor ingrese un texto'
                                    : null,
                            onChanged: (value) =>
                                entryForm.cedula = value.trim(),
                          ),
                        ),
                        entryForm.fotoCedula
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
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
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            entryForm.nombreBool
                ? _espacio(
                    TextFormField(
                      // initialValue: initialValue,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecorations.authInputDecoration(
                        labelText: 'Nombre Completo',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Por favor ingrese un texto'
                          : null,
                      onChanged: (value) => entryForm.nombre = value.trim(),
                    ),
                  )
                : Container(),
            entryForm.calleBool
                ? _espacio(
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
                      onChanged: (value) => entryForm.calle = value.trim(),
                    ),
                  )
                : Container(),
            entryForm.numeroBool
                ? _espacio(
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
                      onChanged: (value) => entryForm.numero = value.trim(),
                    ),
                  )
                : Container(),
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
                onChanged: (value) => entryForm.observacion = value.trim(),
              ),
            ),
            _espacio(
              Row(
                children: [
                  Expanded(
                    child: SwitchListTile(
                      title: Text('Ingreso'),
                      value: entryForm.ingreso,
                      onChanged: (valor) => entryForm.ingreso = valor,
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.deepPurple,
                      child: Container(
                          child: Text(
                        entryForm.isLoading ? 'Espera' : 'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                      onPressed: entryForm.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              final ingresoService =
                                  Provider.of<IngresarProvider>(
                                context,
                                listen: false,
                              );
                              if (!entryForm.isValidForm()) return;
                              entryForm.isLoading = true;

                              // print(entryForm.idTipoIngreso);
                              // print(entryForm.empresa);
                              // print(entryForm.placa);
                              // print(entryForm.cedula);
                              // print(entryForm.calle);
                              // print(entryForm.numero);
                              // print(entryForm.ingreso);
                              // print(entryForm.observacion);

                              entryForm.isLoading = false;

                              final String? errorMessage =
                                  await ingresoService.crearIngreso(
                                entryForm.idTipoIngreso,
                                entryForm.empresa == null ||
                                        entryForm.empresa == ''
                                    ? null
                                    : entryForm.empresa,
                                entryForm.placa,
                                entryForm.nombre == null ||
                                        entryForm.nombre == ''
                                    ? null
                                    : entryForm.nombre,
                                entryForm.cedula,
                                'no',
                                entryForm.calle,
                                entryForm.numero,
                                entryForm.ingreso ? 1 : 0,
                                entryForm.observacion,
                              );
                              if (errorMessage == null) {
                                entryForm.isLoading = false;
                                //  ingresoService.getTopHeadlines();
                              } else {
                                final snackBar = new SnackBar(
                                  content: Text(
                                    errorMessage,
                                    style: TextStyle(
                                      color: Colors.blueGrey[900],
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                entryForm.isLoading = false;
                              }
                            },
                    ),
                  ),
                ],
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
