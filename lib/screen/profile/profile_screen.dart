import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/screen/profile/profile_screen_view_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileScreenViewModel model;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();

  bool editMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    print("Current page --> $runtimeType");
    model ?? (model = ProfileScreenViewModel(this));
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorRes.primaryColor,
        appBar: commonAppbar(context),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: height-120,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    commonTitle('Profile'),
                    SizedBox(height: 30),
                   model.profileModel ==null ? Container()  :profileDetails(),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                if(editMode) {
                  model.profileModel.firstName = fName.text ;
                  model.profileModel.lastName = lName.text;
                  await model.updateProfile();
                  setState(() {
                    fName.clear();
                    lName.clear();
                    editMode = false;
                  });
                }else{
                  setState(() {
                    fName.text = model.profileModel.firstName;
                    lName.text = model.profileModel.lastName;
                    editMode = true;
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.06,
                width: width * 0.92,
                padding: EdgeInsets.symmetric(horizontal: 20),
                // margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: ColorRes.red,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text( editMode ? "Update" : 'Edit',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'NeueFrutigerWorld',
                      fontWeight: FontWeight.w500),),
              ),
            )
          ],
        ),
      ),
    );
  }

  profileDetails() {
    Size media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //First name
            Text(
              'First Name',
              style: TextStyle(
                fontFamily: 'NeueFrutigerWorld',
                fontSize: 16,
                color: ColorRes.dimGray,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: media.width * 0.06),
              child: TextFormField(
                readOnly: !editMode,
                controller: fName,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  hintText:
                      '${model.profileModel == null ? 'Rakesh' : model.profileModel.firstName}',
                  hintStyle: TextStyle(
                    fontFamily: 'NeueFrutigerWorld',
                    fontSize: 16,
                    color: ColorRes.charcoal.withOpacity(0.5),
                  ),
                  contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
                ),
              ),
            ),
            SizedBox(height: 20),

            //Last name
            Text(
              'Last Name',
              style: TextStyle(
                fontFamily: 'NeueFrutigerWorld',
                fontSize: 16,
                color: ColorRes.dimGray,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: media.width * 0.06),
              child: TextFormField(
                readOnly: !editMode,
                controller: lName,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  hintText:
                      '${model.profileModel == null ? 'Patwal' : model.profileModel.lastName}',
                  hintStyle: TextStyle(
                    fontFamily: 'NeueFrutigerWorld',
                    fontSize: 16,
                    color: ColorRes.charcoal.withOpacity(0.5),
                  ),
                  contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
                ),
              ),
            ),
            SizedBox(height: 20),

            //Gender
            Text(
              'Gender',
              style: TextStyle(
                fontFamily: 'NeueFrutigerWorld',
                fontSize: 16,
                color: ColorRes.dimGray,
              ),
            ),
            Row(
              children: <Widget>[
                addRadioButton(0, 'Male'),
                addRadioButton(1, 'Female'),
              ],
            ),
            /*  Padding(
             padding: EdgeInsets.only(right: media.width * 0.06),
             child: TextFormField(
               readOnly: true,
               decoration: InputDecoration(
                 enabledBorder: UnderlineInputBorder(
                   borderSide: BorderSide(color: Colors.grey.shade100),
                 ),
                 focusedBorder: UnderlineInputBorder(
                   borderSide: BorderSide(color: Colors.grey.shade100),
                 ),
                 filled: true,
                 fillColor: const Color(0xFFFFFFFF),
                 hintText: '${model.profileModel == null ? 'Male' : model.profileModel.gender}',
                 hintStyle: TextStyle(
                   fontFamily: 'NeueFrutigerWorld',
                   fontSize: 16,
                   color: ColorRes.charcoal.withOpacity(0.5),
                 ),
                 contentPadding: EdgeInsets.only(left: 0.0,bottom: 10),
               ),
             ),
           ),*/
            SizedBox(height: 20),

            //Email
            Text(
              'Email',
              style: TextStyle(
                fontFamily: 'NeueFrutigerWorld',
                fontSize: 16,
                color: ColorRes.dimGray,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: media.width * 0.06),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  hintText:
                      '${model.profileModel == null ? 'rakesh.patwal@signtific.co.in' : model.profileModel.email}',
                  hintStyle: TextStyle(
                    fontFamily: 'NeueFrutigerWorld',
                    fontSize: 16,
                    color: ColorRes.charcoal.withOpacity(0.5),
                  ),
                  contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
                ),
              ),
            ),
            SizedBox(height: 20),

            //Phone Number
            Text(
              'Phone Number',
              style: TextStyle(
                fontFamily: 'NeueFrutigerWorld',
                fontSize: 16,
                color: ColorRes.dimGray,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: media.width * 0.06),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  hintText:
                      '${model.profileModel == null ? '+91 9958 314 088' : model.profileModel.mobile}',
                  hintStyle: TextStyle(
                    fontFamily: 'NeueFrutigerWorld',
                    fontSize: 16,
                    color: ColorRes.charcoal.withOpacity(0.5),
                  ),
                  contentPadding: EdgeInsets.only(left: 0.0, bottom: 10),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  List gender = ["Male", "Female"];
  int groupValue = 0;
  String select;
  Row addRadioButton(int value, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
       Radio(
          activeColor: Theme.of(context).primaryColor,
          value:value,
          groupValue:model.profileModel.gender == 'male' ? 0 : 1, onChanged: editMode ? (int value) {
            model.profileModel.gender = value==9 ? "male" : "female" ;
            setState(() {

            });
       } : null,
        ) ,
        Text(
          title, style: TextStyle(fontFamily: 'NeueFrutigerWorld', fontSize: 16, color: ColorRes.charcoal.withOpacity(0.5),
          ),
        )
      ],
    );
  }
}
