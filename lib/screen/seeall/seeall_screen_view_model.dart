import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/seeall/seeall_screen.dart';

class SeeAllScreenViewModel{

  SeeAllScreenState state;


  SeeAllScreenViewModel(this.state){
    newProductData();
  }

  List<HomeScreenModel> newProductName = [];

  newProductData() {
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Product name",
      productUrl:Utils.getAssetsHomeImg('product_name_first'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Product name",
      productUrl:Utils.getAssetsHomeImg('product_name_second'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Woman T-Shirt",
      productUrl:Utils.getAssetsHomeImg('product_name_third'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Product name",
      productUrl:Utils.getAssetsHomeImg('product_name_first'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Product name",
      productUrl:Utils.getAssetsHomeImg('product_name_second'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Woman T-Shirt",
      productUrl:Utils.getAssetsHomeImg('product_name_third'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Product name",
      productUrl:Utils.getAssetsHomeImg('product_name_first'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Product name",
      productUrl:Utils.getAssetsHomeImg('product_name_second'),
    ),);
    newProductName.add(HomeScreenModel(
      productPriceAfter: "\$305",
      productPriceBefore: "\$455",
      productName: "Woman T-Shirt",
      productUrl:Utils.getAssetsHomeImg('product_name_third'),
    ),);
  }

}