import 'dart:convert';
import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/login_ref_model.dart';
import 'package:homesaaz/service/base_url.dart';
import 'package:http/http.dart' as http;

class RestApi{

  static String baseUrl = "http://projects.doorsstudio.com/homesaaz/api/";

  static String username = 'admin';
  static String password = '1234';

  static Future getLoginApi(){
    return null;
  }

  //Register Api
  static Future<http.Response> signUp(Map<String, dynamic> registerData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/signup";
    print(url + registerData.toString());
   try {
     http.Response response = await http.post(url, headers: {'Authorization': auth}, body: registerData);
     Map result = jsonDecode(response.body);
     if(response.statusCode == 200 || response.statusCode == 201) {
       print(result);
       return response;
     } else if(response.statusCode == 401) {
       Utils.showToast("Unauthorized user");
       return null;
     }
   } catch(e) {
     Utils.showToast(e);
     return null;
   }
  }


//   Future<User> register(User user) async {
//     final String url = '${GlobalConfiguration().getString('api_base_url')}register';
//     final client = new http.Client();
//     print(json.encode(user.toMapReg()));
//     final response = await client.post(
//       url,
//       headers: {HttpHeaders.contentTypeHeader: 'application/json'},
//       body: json.encode(user.toMapReg()),
//     );
//     if (response.statusCode == 200) {
//       setCurrentUser(response.body);
//       currentUser.value = User.fromJSON(json.decode(response.body)['data']);
//     } else {
//       print(CustomTrace(StackTrace.current, message: response.body).toString());
//       if(response.body!=null) {
//         throw json.decode(response.body)['message'];
// //      throw new Exception(json.decode(response.body)['message']);
//       } else {
//         throw new Exception(response.body);
//       }
//     }
//     return currentUser.value;
//   }

  //login api
  static Future<LoginPageModel> isLogin(String login_username, String login_password) async {
    String url = baseUrl + "user/validate_login";
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