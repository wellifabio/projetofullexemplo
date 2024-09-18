import 'package:flutter/material.dart';
import 'package:serv_facil/model/comment.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/services/comment_service.dart';
import 'package:serv_facil/widgets/UI/modal/comment_widget.dart';

class CommentsModal extends StatelessWidget {
  const CommentsModal({
    super.key,
    required this.colaborador,
    required this.os,
  });

  final User? colaborador;
  final Os os;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: 5,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Comentários',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder(
                  future: CommentService.getComments(
                    token: colaborador!.token!,
                    osId: os.id,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      final data = snapshot.data!;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final Comment comment = data[index];
                          return CommentWidget(comment: comment);
                        },
                      );
                    } else {
                      return const Text(
                        'Essa Os não possui comentários.',
                        style: TextStyle(fontSize: 20),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
