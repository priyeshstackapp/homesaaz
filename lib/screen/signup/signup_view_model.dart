import 'package:flutter/material.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/signup/signup_screen.dart';

class SignUpViewModel {
  SignUpScreenState state;

  SignUpViewModel(this.state);

  signUp() async {

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