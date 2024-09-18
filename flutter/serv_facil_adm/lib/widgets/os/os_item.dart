import 'package:flutter/material.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/widgets/modal/modal_details.dart';
import 'package:serv_facil/widgets/os/os_item_info.dart';
import 'package:serv_facil/widgets/UI/small_button.dart';

class OsItem extends StatelessWidget {
  const OsItem({
    super.key,
    required this.os,
  });

  final Os os;

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        color: os.finished
            ? Theme.of(context).colorScheme.tertiary.withOpacity(0.55)
            : Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  os.descricao,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: !os.finished
                        ? Theme.of(context).colorScheme.onTertiary
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              OsItemInfo(
                title: 'Colaborador:',
                content: os.colaborador.nome,
                os: os,
              ),
              os.executor != null
                  ? OsItemInfo(
                      title: 'Executor', content: os.executor!.nome, os: os)
                  : const SizedBox(),
              OsItemInfo(
                title: 'Aberto em:',
                content:
                    '${_formatNumber(os.abertura.day)}/${_formatNumber(os.abertura.month)}/${os.abertura.year}, ${_formatNumber(os.abertura.hour)}:${_formatNumber(os.abertura.minute)}',
                os: os,
              ),
              os.encerramento != null
                  ? OsItemInfo(
                      title: 'Encerrado em:',
                      content:
                          '${_formatNumber(os.encerramento!.day)}/${_formatNumber(os.encerramento!.month)}/${os.encerramento!.year}, ${_formatNumber(os.encerramento!.hour)}:${_formatNumber(os.encerramento!.minute)}',
                      os: os,
                    )
                  : const SizedBox(),
              Align(
                alignment: Alignment.centerRight,
                child: SmallButton(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ModalDetails(
                        os: os,
                      ),
                    );
                  },
                  text: 'Detalhes',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
