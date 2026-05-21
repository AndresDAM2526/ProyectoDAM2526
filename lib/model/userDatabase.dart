class UserDatabase {
  String idUser;
  String username;
  String email;
  String name;
  String role;
  bool firstLogin;

  UserDatabase({
    required this.idUser,
    required this.username,
    required this.email,
    required this.name,
    required this.role,
    required this.firstLogin,
  });
}
