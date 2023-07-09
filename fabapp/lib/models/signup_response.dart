class SignUpResponseModel {
  String username; // TODO : penser à changer en String? si pas de retour
  String email;

  SignUpResponseModel({
    required this.username,
    required this.email,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      username: json['username'] ?? " ",
      email: json['email'] ?? " ",
    );
  }

}
