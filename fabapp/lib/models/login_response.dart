import 'dart:convert';

class LoginResponseModel {
  final String token;

  LoginResponseModel({
    required this.token,
  });

  factory LoginResponseModel.fromJson(String json) {
    return LoginResponseModel(
      token: jsonDecode(json) ?? " ",
    );
  }
}
