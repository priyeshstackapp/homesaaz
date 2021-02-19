import 'dart:convert';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/common/util.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestApi{
  // static String baseUrl = "http://projects.doorsstudio.com/homesaaz/api/";
  static String baseUrl = "https://homesaaz.in/api/";
  static String username = 'admin';
  static String password = '1234';
  static Future getLoginApi(){
    return null;
  }

  //Register Api
  static Future<http.Response> signUp(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/signup";
    print(url);
    print(bodyData);
   try {
     http.Response response = await http.post(url, headers: {'Authorization': auth}, body: bodyData);
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
  static Future<http.Response> dahsBoardApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "home/dashboard";
    print(url);
    print(bodyData);
    try {
      http.Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
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

  //All categories Api
  static Future<http.Response> allCategories() async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "products/all_category";
    print(url);
    try {
      http.Response response = await http.get(url, headers: {'Authorization': auth});
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

  //Dashboard Api
  static Future<http.Response> productListApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "products/productlist";
    print(url);
    print(bodyData);
    try {
      http.Response response;
      response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
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

  //Dashboard Api
  static Future<http.Response> subCatListApi(String id) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "products/subcategories?cat_id=$id";
    print(url);
    try {
      final response = await http.get(url, headers: {'Authorization': auth});
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

  //Categories Api
  static Future<http.Response> categoriesApi() async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "products/all_category";
    print(url);
    try {
      http.Response response = await http.get(url, headers: {'Authorization': auth});
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

  //Update Profile Api
  static Future<http.Response> updateProfileApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/update_user_profile";
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

  //Add to wish Api
  static Future addToWishListApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/addto_wishlist";
    print(url);
    print(bodyData);
    try {
      Response response = await http.post(url, headers: {'Authorization': auth},body: bodyData);
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        if (response != null && jsonData['status'] == "error") {
          Utils.showToast(jsonData['msg']);
        }
      } else if(response.statusCode == 401) {
        Utils.showToast("Unauthorized user");
      } else{
        Utils.showToast("Something went wrong");
      }
    } catch(e) {
      print(e);
     // Utils.showToast(e);
      Utils.showToast("Something went wrong");
    }
  }

  //Remove from wish Api
  static Future<Response> removeWishApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/remove_wishlist";
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

  //Get wish list Api
  static Future<Response> getWishListApi(Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "user/get_wishlist";
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


  // Get Product details
  static Future<Response> getProductDetails(String productId, Map<String, dynamic> bodyData) async {
    final String auth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String url = baseUrl + "products/product_detail?pid=$productId";
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
      throw e;
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

  static Future<String> paytm(String bodyData) async {

    String url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    print(url);
    print(bodyData);

    try {
      Response response = await http.post(
        url,
        body: bodyData,
        headers: {'Content-type': "application/json"},
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode==200){
        String txnToken = response.body;
        return txnToken;
      }else{
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}