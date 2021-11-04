import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fringreso/src/providers/ui_provider.dart';

class CustomNavigationbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectdMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectdMenuOpt = i,
      currentIndex: currentIndex,
      elevation: 0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outlined),
          label: 'Historial',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_low_rounded),
          label: 'Configuracion',
        ),
      ],
    );
  }
}
