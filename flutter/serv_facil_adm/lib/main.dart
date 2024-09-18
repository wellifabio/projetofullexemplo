import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serv_facil/provider/user_provider.dart';
import 'package:serv_facil/screens/home.dart';
import 'package:serv_facil/screens/login.dart';
import 'package:serv_facil/screens/register.dart';
import 'package:serv_facil/theme/light_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MainApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: '/login',
      theme: LightTheme().theme,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
