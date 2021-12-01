import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fringreso/src/pages/config_page.dart';
import 'package:fringreso/src/pages/home_page.dart';
import 'package:fringreso/src/pages/login_page.dart';
import 'package:fringreso/src/providers/ui_provider.dart';
import 'package:fringreso/src/pages/entry_page.dart';
import 'package:fringreso/src/providers/tipo_ingreso_provider.dart';
import 'package:fringreso/src/providers/ingresar_provider.dart';
import 'package:fringreso/src/pages/check_auth_page.dart';
import 'package:fringreso/src/providers/auth_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new AuthProvider()),
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new TipoIngresoProvider()),
        ChangeNotifierProvider(create: (_) => new IngresarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ingreso',
        initialRoute: 'home',
        routes: {
          'checking': (_) => CheckAuthPage(),
          'home': (BuildContext contex) => HomePage(),
          'entry': (BuildContext contex) => EntryPage(),
          'config': (BuildContext contex) => ConfigPage(),
          'login': (BuildContext context) => LoginPage(),
        },
        // theme: ThemeData.dark(),
      ),
    );
  }
}
