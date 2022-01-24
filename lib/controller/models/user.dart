class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  String website;
  String? imageUrl;

  Map address;
  Map company;
  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.company,
      required this.phone,
      required this.website,
      this.imageUrl});

  factory User.fromJson(json) {
    return User(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        address: json['address'],
        company: json['company'],
        phone: json['phone'],
        website: json['website']);
  }
}
