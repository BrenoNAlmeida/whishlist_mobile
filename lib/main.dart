import 'package:flutter/material.dart';
import 'package:wishlist/screens/createWishlistScren/index.dart';
import 'package:wishlist/screens/loginScreen/index.dart';
import 'package:wishlist/screens/dashboardScreen/index.dart';

void main() {
  runApp(WishlistApp());
}

class WishlistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wishlist App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/dashboard/create-wishlist': (context) => CreateWishlistScreen(),
      },
    );
  }
}
