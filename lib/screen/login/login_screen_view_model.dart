import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/login/login_screen.dart';

class LoginScreenViewModel {
  LoginScreenState state;

  LoginScreenViewModel(this.state);

  login() async {}

  bool validate() {
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
  }

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
