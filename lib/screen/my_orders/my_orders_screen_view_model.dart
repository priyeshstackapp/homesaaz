import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/my_order_model.dart';
import 'package:homesaaz/screen/my_orders/my_orders_screen.dart';

class MyOrdersScreenViewModel {
  MyOrdersScreenState state;

  MyOrdersScreenViewModel(MyOrdersScreenState state) {
    this.state = state;
    newProductData();
  }

  List<MyOrdersModel> newProductName = [];

  newProductData() {
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productName: "Product name",
      productCode: "SM12435",
      rating: 3,
      imageUrl:Utils.homeImg('product_name_first'),
    ),);
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      productName: "Product name",
      rating: 4,
      imageUrl:Utils.homeImg('product_name_second'),
    ),);
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      rating: 1,
      productName: "Woman T-Shirt",
      imageUrl:Utils.homeImg('product_name_third'),
    ),);
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      rating: 2,
      productName: "Woman T-Shirt",
      imageUrl:Utils.homeImg('product_name_third'),
    ),);
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      productName: "Woman T-Shirt",
      rating: 5,
      imageUrl:Utils.homeImg('product_name_third'),
    ),);
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      productName: "Woman T-Shirt",
      rating: 2,
      imageUrl:Utils.homeImg('product_name_third'),
    ),);
    newProductName.add(MyOrdersModel(
      newPrice: "\$305",
      oldPrice: "\$455",
      productCode: "SM12435",
      productName: "Woman T-Shirt",
      rating: 3,
      imageUrl:Utils.homeImg('product_name_third'),
    ),);
  }
}
