import 'package:flutter/material.dart';
import 'package:homesaaz/common/colorres.dart';
import 'package:homesaaz/common/common_route.dart';
import 'package:homesaaz/common/common_widget.dart';
import 'package:homesaaz/model/dashboard_model.dart';
import 'package:homesaaz/screen/seeall/categories_all_view_model.dart';

class CategoriesAll extends StatefulWidget {
  @override
  CategoriesAllState createState() => CategoriesAllState();
}

class CategoriesAllState extends State<CategoriesAll> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  CategoriesAllViewModel model;

  @override
  Widget build(BuildContext context) {
    print("Current page --> $runtimeType");
    model ?? (model = CategoriesAllViewModel(this));

    return Scaffold(
      backgroundColor: ColorRes.primaryColor,
      appBar: commonAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 30, color: ColorRes.textColor),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.categories != null &&
                    model.categories.length != 0
                    ? model.categories.length : 0,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13.0,
                    childAspectRatio: 1.6,
                    //childAspectRatio: MediaQuery.of(context).size.width /
                    //   (MediaQuery.of(context).size.height / 3),
                    mainAxisSpacing: 17.0
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      gotoSeeAllScreen(
                          context,
                          model.categories[index].categoryName,model.categories[index].categoryId);
                    },
                    child: Stack(
                      children: [
                        Image.network(
                          model.categories[index].categoryImage,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5.5,
                                spreadRadius: 1.5,
                                offset: Offset(4.4, 9.0),
                              ),
                            ],
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              model.categories[index].categoryName,
                              // model.categoriesName[index],
                              style: new TextStyle(
                                  fontSize: 12,
                                  backgroundColor: ColorRes.dimGray,
                                  color: ColorRes.whiteColor,
                                  fontFamily: 'NeueFrutigerWorld',
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
