import 'package:flutter/material.dart';
import 'package:serv_facil/main.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Image.asset(
                  'assets/icone.png',
                  height: 50,
                ),
                const SizedBox(width: 10),
                Image.asset(
                  'assets/logomarca.png',
                  height: 35,
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => navigatorKey.currentState?.pushReplacementNamed('/home'),
            leading: Icon(
              Icons.home_outlined,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            onTap: () => navigatorKey.currentState?.pushReplacementNamed('/production'),
            leading: Icon(
              Icons.inventory_2_outlined,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'Produção',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            onTap: () => navigatorKey.currentState?.pushReplacementNamed('/dashboard'),
            leading: Icon(
              Icons.dashboard_outlined,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            onTap: () =>
                navigatorKey.currentState?.pushReplacementNamed('/login'),
            leading: Icon(
              Icons.exit_to_app,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: const Text(
              'Sair',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
