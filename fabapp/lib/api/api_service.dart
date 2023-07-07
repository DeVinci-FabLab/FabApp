import 'package:fabapp/constants/consts.dart';
import 'package:fabapp/models/login_request.dart';
import 'package:fabapp/models/login_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
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
}
