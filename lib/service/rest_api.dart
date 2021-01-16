import 'dart:convert';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApi{
  static String baseUrl = "http://projects.doorsstudio.com/homesaaz/api/";
  static String username = 'admin';
  static String password = '1234';
  static Future getLoginApi(){
    return null;
  }

  //Register Api
  static Future<http.Response> signUp(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/signup";
    print(url + bodyData.toString());
   try {
     http.Response response = await http.post(url, headers: {'Authorization': auth}, body: bodyData);
     Map result = jsonDecode(response.body);
     if(response.statusCode == 200 || response.statusCode == 201) {
       print(result);
       return response;
     } else if(response.statusCode == 401) {
       Utils.showToast("Unauthorized user");
       return null;
     }
   } catch(e) {
     print(e);
     Utils.showToast(e);
     return null;
   }
  }

  //Login Api
  static Future<http.Response> logIn(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/validate_login";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth}, body: bodyData);
      Map result = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      hideLoader();
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(result);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
        Utils.showToast(e);
        return null;
    }
  }

  //Dashboard Api
  static Future<http.Response> dahsBoardApi() async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "home/dashboard";
    print(url);
    try {
      http.Response response = await http.post(url, headers: {'Authorization': auth});
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
  }

  //Profile Api
  static Future<http.Response> profileApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/get_profile";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if(response.statusCode == 401) {
       // Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
     // Utils.showToast(e);
      return null;
    }
  }

  //Address List Api
  static Future<Response> addressListApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/addresslist";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
     // Utils.showToast(e);
      return null;
    }
    return null;
  }

  //Add/Edit address Api
  static Future<Response> addEditAddressApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/add_edit_address";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if(response.statusCode == 401) {
       // Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
     // Utils.showToast(e);
      return null;
    }
    return null;
  }

  //Delete address Api
  static Future<Response> deleteAddressApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/deleteaddress";
    print(url + bodyData.toString());
    try {
      Response response = await http.post(url, headers: {'Authorization': auth});
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      return null;
    }
    return null;
  }

  //Get Complete detail of address
  static Future<Response> getCompleteDetailsOfAddressApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/addressdata";
    print(url);
    print(bodyData);
    try {
      Response response = await http.get(url, headers: {'Authorization': auth});
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }

  // Get Cart items
  static Future<Response> getCartItems(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "cart/getusercart";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }

  // Add to Cart
  static Future<Response> addToCartApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "cart/addItem";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }

  // Remove from Cart
  static Future<Response> removeFromCartApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "cart/removeitem";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }

  // Update product Quantity
  static Future<Response> updateProductQuantity(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "cart/updatequantity";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }



  // Get My orders
  static Future<Response> getMyOrderData(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/orderlist";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }

  // Get Single order
  static Future<Response> getSingleOrderData(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/orderdetail";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }


  // Place order
  static Future<Response> placeOrder(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "cart/saveorder";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      if(response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        print(response.body);
        return response;
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
        return null;
      }
    } catch(e) {
      print(e);
      Utils.showToast(e);
      return null;
    }
    return null;
  }
}