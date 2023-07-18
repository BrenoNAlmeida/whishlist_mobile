class Wish {
  final String id;
  final String name;
  final String description;
  final String link;
  final int list;

  Wish({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.list,
  });

  Wish.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        link = map['link'],
        list = map['list'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'link': link,
      'list': list,
    };
  }

  @override
  String toString() {
    return 'Wish{id: $id, name: $name, description: $description, link: $link, list: $list}';
  }
}
