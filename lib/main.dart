import 'package:flutter/material.dart';
import 'package:wishlist/screens/createWishlistScren/index.dart';
import 'package:wishlist/screens/loginScreen/index.dart';
import 'package:wishlist/screens/dashboardScreen/index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist App',
      home: LoginScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/dashboard') {
          final userId = settings.arguments
              as int; // Obtenha o ID do usuário passado como argumento.
          return MaterialPageRoute(
            builder: (context) => DashboardScreen(userId:userId), // Passe o ID do usuário para a tela de DashboardScreen.
            
          );
        }
      },
    );
  }
}
