class Room {
  String? id;
  String? name;
  String? description;
  String? category;
  String? userId;
  static const String collectionName = "rooms";

  Room({this.id, this.name, this.description, this.category, this.userId});

  Room.fromFirestore(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        category = json['category'],
        userId = json['userId'];

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'userId': userId,
    };
  }
}
