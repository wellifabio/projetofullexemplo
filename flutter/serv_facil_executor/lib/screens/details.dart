import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/widgets/UI/modal/comments_modal.dart';
import 'package:serv_facil/widgets/UI/form_widgets/button.dart';
import 'package:serv_facil/widgets/UI/info_row.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.os,
  });

  final Os os;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  User? colaborador;

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  String _formatDate(DateTime date) {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    return '${_formatNumber(day)}/${_formatNumber(month)}/$year';
  }

  @override
  Widget build(BuildContext context) {
    colaborador = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    widget.os.descricao,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                InfoRow(
                  label: 'Executor',
                  info: widget.os.executor != null
                      ? widget.os.executor!.nome
                      : 'Não possui',
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                InfoRow(
                  label: 'Início',
                  info: _formatDate(widget.os.abertura),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                InfoRow(
                  label: 'Encerramento',
                  info: widget.os.encerramento != null
                      ? _formatDate(widget.os.encerramento!)
                      : 'Não finalizado',
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                Button(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return CommentsModal(
                          colaborador: colaborador,
                          os: widget.os,
                        );
                      },
                    );
                  },
                  text: 'Visualizar Comentários',
                  color: Theme.of(context).colorScheme.tertiary,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: GoogleMap(
          //     initialCameraPosition: CameraPosition(
          //       target: LatLng(widget.os.latitude, widget.os.longitude),
          //       zoom: 13,
          //     ),
          //     markers: {
          //       Marker(
          //         markerId: const MarkerId('Local da Os'),
          //         icon: BitmapDescriptor.defaultMarker,
          //         position: LatLng(widget.os.latitude, widget.os.longitude),
          //       ),
          //     },
          //     rotateGesturesEnabled: false,
          //     zoomControlsEnabled: false,
          //     zoomGesturesEnabled: false,
          //     compassEnabled: false,
          //     scrollGesturesEnabled: false,
          //   ),
          // ),
        ],
      ),
    );
  }
}
