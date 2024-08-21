// lib/models/user.dart
class User {
  final String id;
  final String name;
  final String phone;
  final String joinedAt;
  final String userType;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.joinedAt,
    required this.userType,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      joinedAt: json['joined_at'],
      userType: json['user_type'],
      email: json['email'],
    );
  }
}
