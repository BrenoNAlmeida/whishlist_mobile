class User {
  final int id;
  final String username;
  final String nome;
  static List<String> list = [];

  User({required this.id, required this.username, required this.nome});

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        nome = map['nome'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'nome': nome,
    };
  }

  @override
  String toString() {
    return 'User {id: $id, name: $nome, usuario: $username}';
  }
}
