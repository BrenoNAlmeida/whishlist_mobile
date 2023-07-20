import 'package:flutter/material.dart';
import 'package:wishlist/screens/createWishScreen/index.dart';
import 'package:wishlist/services/models/authService.dart';
import 'package:wishlist/services/models/wishService.dart';

class ViewListScreen extends StatefulWidget {
  static const String routeName = '/view-list-screen';
  final int wishlistId;

  ViewListScreen({required this.wishlistId});

  @override
  _ViewListScreenState createState() => _ViewListScreenState();
}

class _ViewListScreenState extends State<ViewListScreen> {
  final WishService _wishService = WishService();
  //adiciona a variavel de id da lista
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Desejos'),
      ),
      body: FutureBuilder(
        future: _wishService.getWishesFromWishlist(widget.wishlistId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar a lista de desejos.'));
          } else {
            List<dynamic> wishes = snapshot.data as List<dynamic>;

            return ListView.builder(
              itemCount: wishes.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> wish = wishes[index] as Map<String, dynamic>;
                String name = wish['name'] as String;
                String description = wish['description'] as String;
                String url = wish['link'] as String;
                return ListTile(
                  title: Text(name),
                  subtitle: Text(description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewListScreen(
                          wishlistId: wish['id'] as int,
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
              builder: (context) => CreateWishScreen(
                listId: widget.wishlistId,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}