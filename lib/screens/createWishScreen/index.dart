import 'dart:html';

import 'package:flutter/material.dart';
import 'package:wishlist/screens/viewListScreen/index.dart';
import 'package:wishlist/services/models/wishService.dart';

class CreateWishScreen extends StatefulWidget {
  static const routeName = '/create-wishlist-screen';
  final int listId; // Adicione o atributo userId
  CreateWishScreen({required this.listId});

  @override
  _CreateWishScreenState createState() => _CreateWishScreenState();
}

class _CreateWishScreenState extends State<CreateWishScreen> {
  final WishService _wishService = WishService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  dynamic response;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    response = ModalRoute.of(context)?.settings.arguments;
  }

//criar formulario de criacao do modelo wish com name, description, link e price
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Desejo'),
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
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(
                  labelText: 'Link',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o link';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final name = _nomeController.text;
                    final description = _descricaoController.text;
                    final url = _descricaoController.text;

                    Map<String, dynamic> wishData = {
                      'name': _nomeController.text,
                      'description': _descricaoController.text,
                      'link': _linkController.text,
                      'list': this.widget.listId,
                    };

                    final response = await _wishService.post(
                      wishData,
                    );

                    // remove essa lista da pilha e redireciona para a tela de lista de desejos passando o id da lista
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewListScreen(
                          wishlistId: this.widget.listId,
                        ),
                      ),
                    );
                    
                  }
                },
                child: Text('Criar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
