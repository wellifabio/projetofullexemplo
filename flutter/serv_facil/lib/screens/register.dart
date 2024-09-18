import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/services/user_service.dart';
import 'package:serv_facil/widgets/UI/form_widgets/button.dart';
import 'package:serv_facil/widgets/UI/form_widgets/outlinedd_button.dart';
import 'package:serv_facil/widgets/UI/form_widgets/text_input.dart';
import 'package:serv_facil/widgets/UI/form_widgets/text_input_toggle.dart';

final List _dropdownItems = [
  'Setor',
  'Administração',
  'Manutenção',
  'Vendas',
  'Recepção',
  'Contabilidade',
];

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
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  String _dropdownValue = _dropdownItems.first;

  void _addColaborador() async {
    final Map<String, dynamic> data = {
      'matricula': _matriculaController.text,
      'nome': _nomeController.text,
      'cargo': _cargoController.text,
      'setor': _dropdownValue,
      'pin': _pinController.text,
    };

    await UserService.addColaborador(data: data);

    Fluttertoast.showToast(msg: 'Cadastro realizdo com sucesso!');

    navigatorKey.currentState?.pop();
  }

  @override
  void dispose() {
    super.dispose();
    _matriculaController.dispose();
    _nomeController.dispose();
    _cargoController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Column(
                children: [
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira sua matrícula';
                      }
                      return null;
                    },
                    controller: _matriculaController,
                    text: 'Matrícula',
                    keyboardType: TextInputType.number,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira seu nome';
                      }
                      return null;
                    },
                    controller: _nomeController,
                    text: 'Nome',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  TextInput(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira seu cargo';
                      }
                      return null;
                    },
                    controller: _cargoController,
                    text: 'Cargo',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            _dropdownValue == 'Setor') {
                          return 'Selecione seu setor';
                        }
                        return null;
                      },
                      value: _dropdownValue,
                      items:
                          _dropdownItems.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _dropdownValue = value!;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.25),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  TextInputToggle(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira seu PIN';
                      }
                      return null;
                    },
                    controller: _pinController,
                    text: 'PIN',
                    keyboardType: TextInputType.number,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                  TextInputToggle(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira sua confirmação';
                      } else if (value != _pinController.text) {
                        return 'PINs não estão iguais';
                      }
                      return null;
                    },
                    controller: _confirmPinController,
                    text: 'Confirme seu PIN',
                    keyboardType: TextInputType.number,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              ),
              Column(
                children: [
                  Button(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addColaborador();
                      }
                    },
                    text: 'Cadastrar',
                    color: Theme.of(context).colorScheme.tertiary,
                    margin: const EdgeInsets.only(top: 75, bottom: 5),
                  ),
                  OutlineddButton(
                    onPressed: () => navigatorKey.currentState?.pop(),
                    text: 'Já possui um cadastro?',
                    margin: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
