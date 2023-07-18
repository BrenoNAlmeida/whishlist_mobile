class WishList {
  final String id;
  final String name;
  final String description;
  final String user;

  WishList({
    required this.id,
    required this.name,
    required this.description,
    required this.user,
  });

  WishList.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        user = map['user'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'user': user,
    };
  }

  @override
  String toString() {
    return 'Wishlist {id: $id, name: $name, description: $description, user: $user}';
  }
}
