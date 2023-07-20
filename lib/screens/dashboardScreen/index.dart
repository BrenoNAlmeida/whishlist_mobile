import 'package:flutter/material.dart';
import 'package:wishlist/services/models/wishListService.dart';
import 'package:wishlist/screens/viewListScreen/index.dart';
import 'package:wishlist/screens/createWishlistScren/index.dart';


class DashboardScreen extends StatelessWidget {
  final int userId;
  static const routeName = '/dashboard';

  DashboardScreen({required this.userId});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder(
        future: WishListService().getWishListFromUser(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar a wishlist.'),
            );
          } else {
            List<dynamic> wishlists = snapshot.data as List<
                dynamic>; //List<dynamic> wishlists = snapshot.data as List<dynamic>; Faça a conversão para List<dynamic>

            return ListView.builder(
              itemCount: wishlists.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> wishlist =
                    wishlists[index] as Map<String, dynamic>;
                String name =
                    wishlist['name'] as String; // Faça a conversão para String
                return ListTile(
                  title: Text(name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewListScreen(
                          wishlistId: wishlist['id'] as int,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateWishlistScreen(userId: userId),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
    

    
  }
}
