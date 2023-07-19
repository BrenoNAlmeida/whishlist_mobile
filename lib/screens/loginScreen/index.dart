import 'package:flutter/material.dart';
import 'package:wishlist/services/models/authService.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool _error = false;
  final AuthService _authService = AuthService();

  void _onLoginSuccess(int userId) {
    Navigator.pushNamed(context, '/dashboard', arguments: userId);
  }

  Future<void> _authenticateUser(String email, String password) async {
    Map<String, dynamic> userData = {
      'username': email,
      'password': password,
    };
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.login(userData);
      if (response != null) {
        setState(() {
          _isLoading = false;
        });
        _onLoginSuccess(response['id']); // Chame a função _onLoginSuccess passando o ID do usuário retornado pela resposta.
      } else {
        setState(() {
          _isLoading = false;
          _error = true;
        });
      }
    } catch (e) {
      setState(() {
        _error = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Wishlist App'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Wishlist App'),
        ),
        body: Center(
          child: LoginForm(
            onLogin: _authenticateUser,
          ),
        ),
      );
    }
  }
}

class LoginForm extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginForm({required this.onLogin});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira um email válido.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira uma senha válida.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  widget.onLogin(username, password);
                }
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
