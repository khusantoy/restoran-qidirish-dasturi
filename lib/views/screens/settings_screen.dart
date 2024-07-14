import 'package:flutter/material.dart';
import 'package:restoran_qidirish_dasturi/controllers/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
