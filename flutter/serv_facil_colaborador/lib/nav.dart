import 'package:flutter/material.dart';
import 'package:serv_facil/screens/home.dart';
import 'package:serv_facil/screens/my_oss.dart';
import 'package:serv_facil/widgets/modal/modal_add_os.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final List<Widget> _screens = const [
    HomeScreen(),
    MyOss(),
  ];

  int _currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (value) {
          setState(() {
            _currentScreen = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.all_inbox,
              size: 28,
            ),
            label: 'Todas OS',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.my_library_books,
              size: 28,
            ),
            label: 'Minhas OS',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const ModalAddOs(),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
          weight: 100,
        ),
      ),
    );
  }
}
