import 'dart:convert';

class SignUpResponseModel {
  String code; // TODO : penser à changer en String? si pas de retour
  String message;

  SignUpResponseModel({
    required this.code,
    required this.message,
  });

  factory SignUpResponseModel.fromJson(String response) {
    dynamic json = jsonDecode(response);
    return SignUpResponseModel(
      code: json['code'] ?? " ",
      message: json['message'] ?? " ",
    );
  }

}
