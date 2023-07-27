class MyUser {
  String id;
  String name;
  String email;
  static const String collectionName = "users";

  MyUser({required this.id, required this.name, required this.email});

  // From JSON constructor
  MyUser.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          email: json['email'],
        );

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
