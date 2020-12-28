import 'package:flutter/material.dart';
import 'package:homesaaz/app.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/signup/signup_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({
    Key key,
    this.first_name,
    this.last_name,
    this.mobileno,
    this.email,
    this.password,
    this.conf_password,
  }) : super(key: key);
  final String first_name;
  final String last_name;
  final int mobileno;
  final String email;
  final String password;
  final String conf_password;

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  SignUpViewModel model;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController conformPasswordController = TextEditingController();

  // TextEditingController userIdCont = TextEditingController();

  final GlobalKey<ScaffoldState> loginKey = new GlobalKey<ScaffoldState>();
  // GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  SharedPreferences preferences;

  bool isLoading = false;
  bool _passwordVisible = true;

  _validateInputs() async {
    model.registerApi();
    /*if (firstNameController.text != '' &&
        lastNameController.text != '' &&
        mobileController.text != '' &&
        emailController.text != '' &&
        passwordCont.text != '' &&
        conformPasswordController.text != '') {
      model.nextButtonGotoSignUpPage(context);
    } else {
      setState(() {
        print('=======================data not found...');

      });
    }*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = SignUpViewModel(this));

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      key: loginKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: InkWell(
                onTap: () => gotoLoginScreenUntilRemove(context),
                child: Image.asset(
                  App.left_arrow,
                  color: ColorRes.dimGray.withOpacity(0.3),
                  height: 22,
                  width: 22,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30, left: 20),
              child: commonTitle('Signup'),
            ),
            SizedBox(height: 20),
            firstNameView(),
            lastNameView(),
            phoneNumberView(),
            emailView(),
            passwordView(),
            conformPasswordView(),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  _validateInputs();
                  /*      if (model.validate()) {
                      setState(() {
                        isLoading = true;
                        gotoHomeScreen(context);
                      });
                      model.signUp();
                  }*/
                },
                child: gradientButton(context, title: "Sign Up"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  gotoLoginScreenUntilRemove(context);
                  /*if (!isLoading) {
                    replaceWithLoginScreen(context);
                  }*/
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorRes.dimGray,
                          fontFamily: 'NeueFrutigerWorld',
                          fontSize: 14),
                    ),
                    Text(
                      " Sign in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorRes.textColor,
                          fontFamily: 'NeueFrutigerWorld',
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  firstNameView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "First name",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'NeueFrutigerWorld',
                color: ColorRes.textColor),
          ),
          TextFormField(
            style: TextStyle(fontSize: 14, color: ColorRes.textColor),
            cursorColor: ColorRes.textColor,
            controller: firstNameController,
            decoration: InputDecoration(
              hintText: "Enter first name",
              hintStyle: TextStyle(
                  color: ColorRes.textColor.withOpacity(0.4), fontSize: 14),
              focusColor: ColorRes.textColor,
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
            ),
          ),
        ],
      ),
    );
  }

  lastNameView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last name",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'NeueFrutigerWorld',
                color: ColorRes.textColor),
          ),
          TextFormField(
            style: TextStyle(fontSize: 14, color: ColorRes.textColor),
            cursorColor: ColorRes.textColor,
            controller: lastNameController,
            decoration: InputDecoration(
              hintText: "Enter last name",
              hintStyle: TextStyle(
                  color: ColorRes.textColor.withOpacity(0.4), fontSize: 14),
              focusColor: ColorRes.textColor,
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
            ),
          ),
        ],
      ),
    );
  }

  phoneNumberView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Phone",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'NeueFrutigerWorld',
                color: ColorRes.textColor),
          ),
          TextFormField(
            style: TextStyle(fontSize: 14, color: ColorRes.textColor),
            cursorColor: ColorRes.textColor,
            controller: mobileController,
            decoration: InputDecoration(
              hintText: "Enter phone number",
              hintStyle: TextStyle(
                  color: ColorRes.textColor.withOpacity(0.4), fontSize: 14),
              focusColor: ColorRes.textColor,
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
            ),
          ),
        ],
      ),
    );
  }

  emailView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'NeueFrutigerWorld',
                color: ColorRes.textColor),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 14, color: ColorRes.textColor),
            cursorColor: ColorRes.textColor,
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Enter email id",
              hintStyle: TextStyle(
                  color: ColorRes.textColor.withOpacity(0.4), fontSize: 14),
              focusColor: ColorRes.textColor,
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
            ),
          ),
        ],
      ),
    );
  }

  passwordView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'NeueFrutigerWorld',
                color: ColorRes.textColor),
          ),
          TextFormField(
            style: TextStyle(fontSize: 14, color: ColorRes.textColor),
            cursorColor: ColorRes.textColor,
            controller: passwordCont,
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              hintText: "Enter password",
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: ColorRes.textColor.withOpacity(0.3),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              hintStyle: TextStyle(
                color: ColorRes.textColor.withOpacity(0.4),
                fontSize: 14,
              ),
              focusColor: ColorRes.textColor,
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
            ),
          ),
        ],
      ),
    );
  }

  conformPasswordView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Conform password",
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'NeueFrutigerWorld',
                color: ColorRes.textColor),
          ),
          TextFormField(
            style: TextStyle(fontSize: 14, color: ColorRes.textColor),
            cursorColor: ColorRes.textColor,
            controller: conformPasswordController,
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              hintText: "Enter conform password",
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: ColorRes.textColor.withOpacity(0.3),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              hintStyle: TextStyle(
                color: ColorRes.textColor.withOpacity(0.4),
                fontSize: 14,
              ),
              focusColor: ColorRes.textColor,
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.5))),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorRes.textColor.withOpacity(0.3))),
            ),
          ),
        ],
      ),
    );
  }
}
