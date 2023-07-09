import 'package:fabapp/constants/consts.dart';
import 'package:fabapp/models/login_request.dart';
import 'package:fabapp/models/login_response.dart';
import 'package:fabapp/models/signup_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fabapp/models/signup_request.dart';

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async { // TODO : changer nomentlature
    final response = await http.get(Uri.parse(Constants.uriSignIn),
        headers: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(response.body);
    } else if (response.statusCode == 500) {
      return LoginResponseModel();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<SignUpResponseModel> signUp(SignUpRequestModel requestModel) async {
    final response = await http.post(Uri.parse(Constants.uriSignUp),
        body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      return SignUpResponseModel.fromJson(json.decode(response.body)); // TODO : ajouter gestion de l'erreur, sinon tombe directement dans le else
    // } else if (response.statusCode == 500) {
    //   return SignUpResponseModel();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
