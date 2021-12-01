import 'package:flutter/material.dart';
import 'package:fringreso/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
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
          ),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.red,
            child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 15,
                ),
                child: Text(
                  'Salir',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
