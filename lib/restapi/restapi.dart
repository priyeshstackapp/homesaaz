import 'dart:convert';
import 'package:homesaaz/model/login_ref_model.dart';
import 'package:http/http.dart' as http;

class RestApi{

  static Future getLoginApi(){
    return null;
  }
  static Future<String> isSignUp(Map body) async {
    String url = "http://projects.doorsstudio.com/homesaaz/api/user/signup";
    print(url);
    print(body);
    http.Response response = await http.post(url, body: body);
    Map result = jsonDecode(response.body);

    print(result);
    if (result["status"] == 200 && !result["error"]) {
      throw json.decode(response.body)['message'];
    } else {
      return null;
    }
  }

  static Future<LoginPageModel> isLogin(String login_username, String login_password) async {
    String url = "http://projects.doorsstudio.com/homesaaz/api/user/validate_login";
    Map body = {"login_username": login_username, "password": login_password};
    print(url);
    print(body);
    http.Response response = await http.post(url, body: body);
    Map result = jsonDecode(response.body);

    print("login page response ${response.body}");
    int status = jsonDecode(response.body)['status'];
    bool error = jsonDecode(response.body)['error'];

    print(response.body);

    if (status == 200 && !error) {
      var loginRefModel = LoginPageModel.fromJson(jsonDecode(response.body));
      return loginRefModel;
    } else {
      return null;
    }
  }


}