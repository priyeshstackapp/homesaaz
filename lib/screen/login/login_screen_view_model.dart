import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/model/login_ref_model.dart';
import 'package:homesaaz/screen/login/login_screen.dart';
import 'package:homesaaz/service/rest_api.dart';

class LoginScreenViewModel {
  LoginScreenState state;

  LoginScreenViewModel(this.state);


  Future<bool> isLogin(login_username, login_password) async {
    LoginPageModel loginRefModel = await RestApi.isLogin(login_username, login_password);
    if (loginRefModel != null) {
      return true;
    } else {
      return false;
    }
  }

  login(context) async {

    bool res = await isLogin(emailCont.text,passwordCont.text);
    if (res != null) {
      gotoHomeScreen(context);
      }
    else {
      state.setState(() {
        state.isLoading = false;
      });
      print("Email and Password is wrong!");
    }
  }
/*  bool validate() {
    if (state.emailCont.text == '') {
      showSnackBar(state.scaffoldKey, 'Enter  valid email', isError: true);
      return false;
    } else if (!isEmail(state.emailCont.text.trim())) {
      showSnackBar(state.scaffoldKey,'Enter valid email',isError: true);
      return false;
    }else if (state.passwordCont.text == '') {
      showSnackBar(state.scaffoldKey, 'Enter password', isError: true);
      return false;
    }
    return true;
  }*/

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
