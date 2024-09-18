import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/UI/button.dart';
import 'package:serv_facil/widgets/UI/text_input.dart';

class ModalAddOs extends StatefulWidget {
  const ModalAddOs({super.key});

  @override
  State<ModalAddOs> createState() => _ModalAddOsState();
}

class _ModalAddOsState extends State<ModalAddOs> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();

  void _addOs() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    await OsService.addOs(
      colaborador: user,
      descricao: _descriptionController.text,
    );

    navigatorKey.currentState?.pop(true);
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.25),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Text(
                  'Nova ordem de serviço',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextInput(
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma descrição para cirar uma OS.';
                    }
                    return null;
                  },
                  hintText: 'Descrição',
                  margin: const EdgeInsets.symmetric(vertical: 25),
                ),
                Button(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _addOs();
                    }
                  },
                  text: 'Criar',
                  margin: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
