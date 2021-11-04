import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectdMenuOpt = 0;

  int get selectdMenuOpt {
    return this._selectdMenuOpt;
  }

  set selectdMenuOpt(int i) {
    this._selectdMenuOpt = i;
    notifyListeners();
  }
}
