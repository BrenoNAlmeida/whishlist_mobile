import 'package:flutter/material.dart';
import 'package:wishlist/services/models/wishListService.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  dynamic response;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    response = ModalRoute.of(context)?.settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist App'),
      ),
      body: Center(
        //mostrar a lista de wishlists do usuario logado
        child: FutureBuilder(
          future: WishListService().getAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index]['nome']),
                    subtitle: Text(snapshot.data[index]['descricao']),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard/create-wishlist',
                          arguments: snapshot.data[index]);
                    },
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/dashboard/create-wishlist',
              arguments: response);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
