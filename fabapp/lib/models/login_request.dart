import 'dart:convert';

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() {
    Map<String, String> map = {
      'authorization': 'Basic ${base64Encode('$email:$password'.codeUnits)}'
    };
    return map;
  }
}
