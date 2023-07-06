import 'package:fabapp/constants/consts.dart';
import 'package:fabapp/models/login_request.dart';
import 'package:fabapp/models/login_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response = await http.get(Uri.parse(Constants.uriSignIn),
        headers: requestModel.toJson());
    print(requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500) { // 500 pour code erreur
      return LoginResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
