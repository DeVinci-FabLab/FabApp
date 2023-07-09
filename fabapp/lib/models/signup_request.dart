class SignUpRequestModel {
  String username;
  String email;
  String password;

  SignUpRequestModel({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() {
    Map<String, String> map = {
      'username': username,
      'email': email,
      'password': password,
    };
    return map;
  }
}
