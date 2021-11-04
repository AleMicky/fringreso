import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              'Ajustes',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          SwitchListTile(
            value: true,
            onChanged: (value) {},
            title: Text('Color Secundario'),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la personas usando el telefono',
              ),
              onChanged: (value) {},
            ),
          )
        ],
      ),
    );
  }
}
