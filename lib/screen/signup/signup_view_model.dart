import 'package:fluttertoast/fluttertoast.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/restapi/restapi.dart';
import 'package:homesaaz/screen/signup/signup_screen.dart';

class SignUpViewModel {
  SignUpScreenState state;

  SignUpViewModel(this.state);

  signUp() async {

  }
  Future<bool> isSignUp(String first_name, String last_name,String mobileno, String email,
      String password,String conf_password) async {
    Map body = {
      "first_name": 'Test',
      "last_name": 'User',
      "mobileno": '0123456784',
      "email": 'abhishek12@signtific.co.in',
      "password": '123456',
      "conf_password": '123456'
    };
    String data = await RestApi.isSignUp(body);
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }

  nextButtonGotoSignUpPage(context) async {

    bool res = await isSignUp(state.widget.first_name, state.widget.last_name,
       state.widget.mobileno.toString(), state.widget.email,  state.widget.password,state.widget.conf_password);
    if (res != null && res) {
      gotoHomeScreen(context);
    } else {
      Fluttertoast.showToast(
        msg: "Email address already exists.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }


  bool validate() {
   /* if (state.userIdCont.text == '') {
      showSnackBar(state.scaffoldKey,'Enter username',isError: true);
      return false;
    }else*/
      if (state.firstNameController.text == '') {
      showSnackBar(state.scaffoldKey,'Enter name',isError: true);
      return false;
    } else if (state.emailController.text == '') {
      showSnackBar(state.scaffoldKey,'Enter email',isError: true);
      return false;
    } else if (!isEmail(state.emailController.text.trim())) {
      showSnackBar(state.scaffoldKey,'Enter valid email',isError: true);
      return false;
    } else if (state.passwordCont.text == '') {
      showSnackBar(state.scaffoldKey,'Enter password',isError: true);
      return false;
    }
    return true;
  }

  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  /*void registerApi() async {
    FocusScope.of(state.context).unfocus();
    if (loginFormKey.currentState.validate() && customValidation()) {
      // loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.register(user).then((value) {
        if (value != null && value.apiToken != null) {
          vehicleRepo.getVehicleType();
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 1);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader?.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    } else {
      validateForm = true;
      setState((){});
    }
  }*/


}