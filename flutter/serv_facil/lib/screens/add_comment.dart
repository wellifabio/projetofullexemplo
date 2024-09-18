import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/comment_service.dart';
import 'package:serv_facil/widgets/UI/form_widgets/button.dart';
import 'package:serv_facil/widgets/UI/form_widgets/text_input.dart';

class AddCommentScreen extends StatelessWidget {
  AddCommentScreen({
    super.key,
    required this.os,
    required this.action,
  });

  final Os os;
  final Function() action;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  void _addComment(BuildContext context) async {
    final User colaborador = Provider.of<UserProvider>(context, listen: false).user;

    final Map<String, dynamic> data = {
      'os': os.id,
      'colaborador': colaborador.matricula,
      'comentario': _controller.text,
    };

    await CommentService.addComment(token: colaborador.token!, data: data);

    action();

    navigatorKey.currentState?.pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OS ${os.id}',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                os.descricao,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              TextInput(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira um comentário.';
                  }
                  return null;
                },
                controller: _controller,
                text: 'Insira seu comentário',
                margin: const EdgeInsets.only(bottom: 10),
              ),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      onPressed: () => navigatorKey.currentState?.pop(),
                      text: 'Cancelar',
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Button(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addComment(context);
                        }
                      },
                      text: 'Finalizar',
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
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
