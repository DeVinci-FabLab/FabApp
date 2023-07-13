import 'package:fabapp/constants/consts.dart';
import 'package:fabapp/models/login_request.dart';
import 'package:fabapp/models/login_response.dart';
import 'package:fabapp/models/signup_response.dart';
import 'package:http/http.dart' as http;
import 'package:fabapp/models/signup_request.dart';

class ApiService {
  Future<LoginResponseModel> signIn(LoginRequestModel requestModel) async {
    final response = await http.get(Uri.parse(Constants.uriSignIn),
        headers: requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponseModel.fromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 500) {
      return LoginResponseModel();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SignUpResponseModel> signUp(SignUpRequestModel requestModel) async {
    final response = await http.post(Uri.parse(Constants.uriSignUp),
        body: requestModel.toJson());
    print(requestModel.toJson());
    print(response.body);
    if (response.statusCode == 200) {
      return SignUpResponseModel.fromJson(response.body);
    } else if (response.statusCode == 400) {
      throw Exception('Bad request');
    } else if (response.statusCode == 409) {
      throw Exception('Conflit');
    } else {
      throw Exception('Failed to load data');
    }
  }
}
