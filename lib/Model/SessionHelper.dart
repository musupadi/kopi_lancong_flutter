class User {
  final String id;
  final String username;
  final String name;

  User({required this.id,required this.username,required this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user["id"] = id;
    user["username"] = this.username;
    user["name"] = this.name;
    return user;
  }
}