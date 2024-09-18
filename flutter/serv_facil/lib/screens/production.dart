import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/model/os.dart';
import 'package:serv_facil/model/user.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/services/os_service.dart';
import 'package:serv_facil/widgets/UI/app_drawer.dart';
import 'package:serv_facil/widgets/os/finished_os_widget.dart';

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({super.key});

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  User? colaborador;

  @override
  Widget build(BuildContext context) {
    colaborador = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produção',
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
          future: OsService.getClosedOss(token: colaborador!.token!),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              final data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final Os os = data[index];
                  return FinishedOsWidget(os: os);
                },
              );
            }
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
