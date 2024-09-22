class User {
  String name;
  String email;
  String dni;
  String phone;
  String? token;
  String? password;

  User({
    required this.name,
    required this.email,
    required this.dni,
    required this.phone,
    this.token,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      dni: json['dni'],
      phone: json['phone'],
      password: json['password'] ?? '',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'name': name,
      'email': email,
      'dni': dni,
      'phone': phone,
    };

    if (password != null) {
      map['password'] = password!;
    }

    return map;
  }
}
