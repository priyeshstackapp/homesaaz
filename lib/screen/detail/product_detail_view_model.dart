import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/product_model.dart';
import 'package:homesaaz/screen/detail/product_detail.dart';

class ProductDetailViewModel {
  ProductDetailScreenState state;

  ProductDetailViewModel(this.state){
    getProduct();
  }
  
  ProductModel product;

  void getProduct() {
    product = ProductModel(
      productName: "Brown Velvet Chair",
      productId: "SA5230",
      newPrice: 305,
      oldPrice: 455,
      size: '21 Dia.',
      description: 'A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine.',
      productUrl: [Utils.assetImage('product1_full_image'),Utils.assetImage('product1_full_image'),Utils.assetImage('product1_full_image'),],
      colors: ['B3261F','696969','FFDD00']
    );
  }
}