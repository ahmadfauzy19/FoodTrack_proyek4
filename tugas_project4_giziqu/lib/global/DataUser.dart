// data_user.dart
class DataUser {
  final String name;
  final String email;
  final String role;
  final String username;
  final String foto;

  DataUser({
    required this.name,
    required this.email,
    required this.role,
    required this.username,
    required this.foto,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      username: json['username'],
      foto: json['foto'],
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, role: $role, username: $username, foto: $foto}';
  }
}
