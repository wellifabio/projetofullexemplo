import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/user_service.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/UI/text_input.dart';
import 'package:serv_facil/widgets/UI/text_input_toggle_eye.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  String _message = '';

  void _login() async {
    try {
      final User user = await UserService.login(
        matricula: _matriculaController.text,
        pin: _pinController.text,
      );

      Provider.of<UserProvider>(context, listen: false).user = user;

      navigatorKey.currentState?.pushReplacementNamed('/home');
    } catch (e) {
      setState(() {
        _message = e.toString().split(':')[1];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _matriculaController.text = '200';
    _pinController.text = '1234';
  }

  @override
  void dispose() {
    super.dispose();
    _matriculaController.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/icone.png',
                    height: 125,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/logomarca.png',
                    width: 250,
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInput(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira sua Matrícula';
                        }
                        return null;
                      },
                      controller: _matriculaController,
                      hintText: 'Matrícula',
                      keyboardType: TextInputType.number,
                    ),
                    TextInputToggleEye(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu PIN';
                        }
                        return null;
                      },
                      controller: _pinController,
                      hintText: 'PIN',
                      keyboardType: TextInputType.number,
                    ),
                    Button(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                      },
                      text: 'Login',
                    ),
                    Button(
                      onTap: () => navigatorKey.currentState?.pushNamed('/register'),
                      text: 'Cadastre-se',
                      filled: false,
                    ),
                    Text(_message == '' ? _message : ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
