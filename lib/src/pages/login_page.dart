import 'package:flutter/material.dart';
import 'package:fringreso/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:fringreso/src/providers/login_form_provider.dart';
import 'package:fringreso/src/widgets/input_decorations.dart';
import 'package:fringreso/src/widgets/auth_background.dart';
import 'package:fringreso/src/widgets/card_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Iniciar Sesion',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Text(
                'DevMonky v1.2',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.send,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecorations.authInputDecoration(
                labelText: 'Cuenta',
                prefixIcon: Icons.person_outline,
              ),
              onChanged: (value) => loginForm.cuenta = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La cuenta debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: loginForm.isObscure,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                filled: true,
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    loginForm.isObscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    loginForm.isObscure = !loginForm.isObscure;
                  },
                ),
                //prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 15,
                ),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthProvider>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.login(
                        loginForm.cuenta,
                        loginForm.password,
                      );

                      if (errorMessage == null) {
                        loginForm.isLoading = false;
                        Navigator.pushReplacementNamed(context, 'home');
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
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        loginForm.isLoading = false;
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
