import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/UI/app_drawer.dart';
import 'package:serv_facil/widgets/os/open_os_widget.dart';
import 'package:serv_facil/widgets/os/taken_os_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? colaborador;

  @override
  Widget build(BuildContext context) {
    colaborador = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu,
              size: 32,
            ),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, right: 10, left: 10),
        child: FutureBuilder(
          future: OsService.getOpenOss(token: colaborador!.token!),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final Os os = data[index];

                  return os.executor?.matricula == colaborador!.matricula
                      ? TakenOsWidget(os: os)
                      : OpenOsWidget(os: os);
                },
              );
            } else {
              return const Text('Nenhuma Os disponível no momento');
            }
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
