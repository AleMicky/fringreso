import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String cuenta = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isObscure(bool value) {
    _isObscure = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
