import 'dart:convert';

class LoginResponseModel {
  final String? token;

  LoginResponseModel({
    this.token,
  });

  factory LoginResponseModel.fromJson(String json) {
    return LoginResponseModel(
      token: jsonDecode(json) ?? " ",
    );
  }
}
