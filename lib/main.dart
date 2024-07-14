import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restoran_qidirish_dasturi/firebase_options.dart';
import 'package:restoran_qidirish_dasturi/services/geolocator_service.dart';
import 'package:restoran_qidirish_dasturi/utils/routes.dart';
import 'package:restoran_qidirish_dasturi/views/screens/auth/login_screen.dart';
import 'package:restoran_qidirish_dasturi/views/screens/auth/register_screen.dart';
import 'package:restoran_qidirish_dasturi/views/screens/auth/reset_password_screen.dart';
import 'package:restoran_qidirish_dasturi/views/screens/home_screen.dart';
import 'package:restoran_qidirish_dasturi/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GeolocatorService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const MainScreen();
            }
            return const LoginScreen();
          }),
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.resetPassword: (context) => const ResetPasswordScreen(),
      },
    );
  }
}
