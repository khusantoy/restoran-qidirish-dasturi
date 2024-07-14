import 'package:flutter/material.dart';
import 'package:restoran_qidirish_dasturi/views/admin_screen.dart';
import 'package:restoran_qidirish_dasturi/views/screens/home_screen.dart';
import 'package:restoran_qidirish_dasturi/views/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          SettingsScreen(),
          const HomeScreen(),
          const AdminScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.black,
        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
            selectedIcon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.map),
            label: "Map",
            selectedIcon: Icon(
              Icons.map,
              color: Colors.white,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.security_rounded),
            label: "Admin panel",
            selectedIcon: Icon(
              Icons.security_rounded,
              color: Colors.white,
            ),
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
