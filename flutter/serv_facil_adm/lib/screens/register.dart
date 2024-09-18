import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/user_service.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/UI/text_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _setorController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _pinConfirmationController =
      TextEditingController();

  void _addUser() async {
    final String token = Provider.of<UserProvider>(context).user.token!;

    final data = <String, dynamic>{
      'matricula': _matriculaController.text,
      'nome': _nomeController.text,
      'cargo': _cargoController.text,
      'setor': _setorController.text,
      'pin': _pinController.text,
    };

    await UserService.addUser(data: data, token: token);
  }

  @override
  void dispose() {
    super.dispose();
    _matriculaController.dispose();
    _nomeController.dispose();
    _cargoController.dispose();
    _setorController.dispose();
    _pinController.dispose();
    _pinConfirmationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Image.asset(
          'assets/logomarca.png',
          width: 175,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text(
              //   'Cadastro de Colaborador',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //     color: Theme.of(context).colorScheme.secondary,
              //   ),
              // ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextInput(
                      controller: _matriculaController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira uma matricula.';
                        }
                        return null;
                      },
                      hintText: 'Matrícula',
                    ),
                    TextInput(
                      controller: _nomeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu nome completo.';
                        }
                        return null;
                      },
                      hintText: 'Nome Completo',
                    ),
                    TextInput(
                      controller: _cargoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu cargo.';
                        }
                        return null;
                      },
                      hintText: 'Cargo',
                    ),
                    TextInput(
                      controller: _setorController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira um setor.';
                        }
                        return null;
                      },
                      hintText: 'Setor',
                    ),
                    TextInput(
                      controller: _pinController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor insira seu PIN.';
                        }
                        return null;
                      },
                      hintText: 'PIN',
                    ),
                    TextInput(
                      controller: _pinConfirmationController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme seu PIN.';
                        } else if (value != _pinController.text) {
                          return 'PINs não correspondentes.';
                        }
                        return null;
                      },
                      hintText: 'Confirme seu PIN',
                    ),
                  ],
                ),
              ),
              Button(onTap: () {
                if (_formKey.currentState!.validate()) {
                  _addUser();
                }
              }, text: 'Cadastrar'),
            ],
          ),
        ),
      ),
    );
  }
}
