import 'package:homesaaz/common/util.dart';
import 'package:homesaaz/model/home_model.dart';
import 'package:homesaaz/screen/home/home_screen.dart';



class HomeScreenViewModel {
  HomeScreenState state;
  List<HomeScreenModel> newProductName = [];
  List<HomeScreenModel> trendingProductsName = [];
  List<HomeScreenModel> featuredProductsName = [];

  HomeScreenViewModel(HomeScreenState state) {
    this.state = state;
    newProductData();
    trendingProductsData();
    featuredProductsData();
  }

  List<String> categoriesNamew = ['Furniture', 'kitchen', 'Bath & Laundry', 'Furnishing', 'Furnishing', 'Decor',];

  //Categories Images
  List<String> categoriesImage = [Utils.homeImg('cat1'), Utils.homeImg('cat2'), Utils.homeImg('cat3'), Utils.homeImg('cat4'), Utils.homeImg('cat5'), Utils.homeImg('cat6'),];

  //Categories Name
  List<String> categoriesName = ['Furniture', 'kitchen', 'Bath & Laundry', 'Furnishing', 'Furnishing', 'Decor',];

  //New Product Images
 // List<String> newProductImage = [Utils.getAssetsHomeImg('product_name_first'), Utils.getAssetsHomeImg('product_name_second'), Utils.getAssetsHomeImg('product_name_third'),];

  //New Product List of data
  newProductData() {
    newProductName.add(HomeScreenModel(
        productPriceAfter: "\$305",
        productPriceBefore: "\$455",
        productName: "Product name",
        productUrl:Utils.homeImg('product_name_first'),
      ),);
    newProductName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name",
          productUrl:Utils.homeImg('product_name_second')
      ),);
    newProductName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Woman T-Shirt",
          productUrl:Utils.homeImg('product_name_third')
      ),);
  }

  //Trending Product Images
 // List<String> trendingProductsImage = [Utils.getAssetsHomeImg('trending_product_first'), Utils.getAssetsHomeImg('trending_product_second'), Utils.getAssetsHomeImg('product_name_third'),];

  //Trending Product List of data
  trendingProductsData() {
    trendingProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name",
          productUrl:Utils.homeImg('trending_product_first'),


    ),);
    trendingProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name",
          productUrl:Utils.homeImg('trending_product_second'),

    ),);
    trendingProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Woman T-Shirt",
          productUrl:Utils.homeImg('product_name_third'),

    ),);
  }

  //Featured Product Images
  //List<String> featuredProductsImage = [Utils.getAssetsHomeImg('featured_product_first'), Utils.getAssetsHomeImg('featured_product_second'), Utils.getAssetsHomeImg('product_name_third'),];

  //Featured Product List of data
  featuredProductsData() {
    featuredProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name",
        productUrl:Utils.homeImg('featured_product_first'),

      ),);
    featuredProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name",
          productUrl:Utils.homeImg('featured_product_second'),
      ),);
    featuredProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Woman T-Shirt",
          productUrl:Utils.homeImg('product_name_third'),
      ),);
  }

}
