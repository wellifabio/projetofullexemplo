import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/UI/app_drawer.dart';
import 'package:serv_facil/widgets/os/finished_os_widget.dart';
import 'package:serv_facil/widgets/os/open_os_widget.dart';
import 'package:serv_facil/widgets/os/taken_os_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  User? colaborador;

  @override
  Widget build(BuildContext context) {
    colaborador = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Todas as OS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700,),),
            const SizedBox(height: 10,),
            Expanded(
              child: FutureBuilder(
                future: OsService.getAllOs(token: colaborador!.token!),
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

                          if (os.encerramento != null) {
                            return FinishedOsWidget(os: os);
                          } else if (os.executor?.matricula ==
                              colaborador!.matricula) {
                            return TakenOsWidget(os: os);
                          } else {
                            return OpenOsWidget(os: os);
                          }
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
