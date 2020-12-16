

import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/cart_model.dart';

import 'checkout_screen.dart';

class CheckoutScreenViewModel {
  CheckoutScreenState state;

  CheckoutScreenViewModel(this.state){
    newProductData();
  }

  List<CartModel> newProductName = [];

  newProductData() {
    newProductName.add(CartModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productName: "Product name",
      productCode: "SM12435",
      imageUrl:Utils.homeImg('product_name_first'),
    ),);
    newProductName.add(CartModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      productName: "Product name",
      imageUrl:Utils.homeImg('product_name_second'),
    ),);

  }
}