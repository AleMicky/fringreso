import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fringreso/src/pages/config_page.dart';
import 'package:fringreso/src/pages/home_page.dart';
import 'package:fringreso/src/pages/login_page.dart';
import 'package:fringreso/src/providers/ui_provider.dart';
import 'package:fringreso/src/pages/entry_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ingreso',
        initialRoute: 'home',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (_) => HomePage(),
          'entry': (_) => EntryPage(),
          'config': (_) => ConfigPage(),
        },
        theme: ThemeData.dark(),
      ),
    );
  }
}
