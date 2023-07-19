import 'package:flutter/material.dart';
import 'package:wishlist/services/models/wishListService.dart';
import 'package:wishlist/screens/dashboardScreen/index.dart';

class CreateWishlistScreen extends StatefulWidget {
  static const routeName = '/create-wishlist-screen';
  final int userId; // Adicione o atributo userId
  CreateWishlistScreen({required this.userId});

  @override
  _CreateWishlistScreenState createState() => _CreateWishlistScreenState();
}

class _CreateWishlistScreenState extends State<CreateWishlistScreen> {
  final WishListService _wishListService = WishListService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();

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
        title: Text('Criar Lista'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Formulário válido, faça algo com os dados

                    Map<String, dynamic> wishListData = {
                      'name': _nomeController.text,
                      'description': _descricaoController.text,
                      'user': this.widget.userId,
                    };
                    try {
                      final responsePost =
                          await _wishListService.post(wishListData);

                      if (responsePost['statusCode'] == '201') {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          DashboardScreen.routeName,
                          (route) =>
                              false, // Remove todas as telas da pilha, exceto a DashboardScreen
                          arguments: this.widget.userId,
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
