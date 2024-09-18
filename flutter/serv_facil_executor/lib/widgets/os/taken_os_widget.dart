import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/screens/add_comment.dart';
import 'package:serv_facil/screens/details.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/UI/form_widgets/button.dart';
import 'package:serv_facil/widgets/UI/info_row.dart';

class TakenOsWidget extends StatefulWidget {
  const TakenOsWidget({
    super.key,
    required this.os,
  });

  final Os os;

  @override
  State<TakenOsWidget> createState() => _TakenOsWidgetState();
}

class _TakenOsWidgetState extends State<TakenOsWidget> {
  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  void _closeOs(BuildContext context) async {
    final Map<String, dynamic> data = {
      'id': widget.os.id,
      'encerramento': DateTime.now().toUtc().toIso8601String(),
    };

    try {
      final String token =
          Provider.of<UserProvider>(context, listen: false).user.token!;

      await OsService.updateOs(token: token, data: data);

      Fluttertoast.showToast(
        msg: 'Os ${widget.os.id} encerrada.',
        backgroundColor: Theme.of(context).colorScheme.primary,
        fontSize: 16,
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(3),
                  topLeft: Radius.circular(3),
                ),
              ),
              child: Text(
                widget.os.descricao,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onTertiary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  InfoRow(
                    label: 'Colaborador',
                    info:
                        '${widget.os.colaborador.nome.split(' ')[0]} ${widget.os.colaborador.nome.split(' ')[1]}',
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  InfoRow(
                    label: 'Executor',
                    info:
                        '${widget.os.executor!.nome.split(' ')[0]} ${widget.os.executor!.nome.split(' ')[1]}',
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  InfoRow(
                    label: 'Início',
                    info:
                        '${_formatNumber(widget.os.abertura.day)}/${_formatNumber(widget.os.abertura.month)}/${widget.os.abertura.year}',
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Button(
                          onPressed: () =>
                              navigatorKey.currentState?.push(
                            MaterialPageRoute(
                              builder: (context) => AddCommentScreen(
                                os: widget.os,
                                action: () => _closeOs(context),
                              ),
                            ),
                          ),
                          text: 'Encerrar',
                          color: Theme.of(context).colorScheme.tertiary,
                          width: double.minPositive,
                        ),
                        const SizedBox(width: 10),
                        Button(
                          onPressed: () => navigatorKey.currentState?.push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(os: widget.os),
                            ),
                          ),
                          text: 'Detalhes',
                          color: Theme.of(context).colorScheme.tertiary,
                          width: double.minPositive,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
