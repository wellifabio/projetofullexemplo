import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/main.dart';
import 'package:serv_facil/models/os.dart';
import 'package:serv_facil/models/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/os/os_item.dart';

class MyOss extends StatefulWidget {
  const MyOss({super.key});

  @override
  State<MyOss> createState() => _MyOssState();
}

class _MyOssState extends State<MyOss> {
  User? colaborador;

  @override
  Widget build(BuildContext context) {
    colaborador = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minhas OS\'s',
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () =>
              navigatorKey.currentState?.pushReplacementNamed('/login'),
          icon: Transform.flip(
            flipX: true,
            child: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        actions: [
          Image.asset(
            'assets/icone.png',
            height: 45,
          ),
        ],
      ),
      body: FutureBuilder(
        future: OsService.getCurrentUserOs(
          colaborador: colaborador!.matricula,
          token: colaborador!.token!,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final Os os = data[index];
                return OsItem(os: os);
              },
            );
          }
        },
      ),
    );
  }
}
