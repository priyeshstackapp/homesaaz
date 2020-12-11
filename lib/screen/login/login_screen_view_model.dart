import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/login/login_screen.dart';

class LoginScreenViewModel {
  LoginScreenState state;

  LoginScreenViewModel(this.state);

  login() async {

  }

  bool validate() {
    if (state.usernameCont.text == '') {
      showSnackBar(state.scaffoldKey,'Enter username',isError: true);
      return false;
    }else if (state.passwordCont.text == '') {
      showSnackBar(state.scaffoldKey,'Enter password',isError: true);
      return false;
    }
    return true;
  }
}