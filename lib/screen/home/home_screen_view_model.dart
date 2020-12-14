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

  //Categories Images
  List<String> categoriesImage = [Utils.getAssetsHomeImg('cat1'), Utils.getAssetsHomeImg('cat2'), Utils.getAssetsHomeImg('cat3'), Utils.getAssetsHomeImg('cat4'), Utils.getAssetsHomeImg('cat5'), Utils.getAssetsHomeImg('cat6'),];

  //Categories Name
  List<String> categoriesName = ['Furniture', 'kitchen', 'Bath & Laundry', 'Furnishing', 'Furnishing', 'Decor',];

  //New Product Images
  List<String> newProductImage = [Utils.getAssetsHomeImg('product_name_first'), Utils.getAssetsHomeImg('product_name_second'), Utils.getAssetsHomeImg('product_name_third'),];

  //New Product List of data
  newProductData() {
    newProductName.add(HomeScreenModel(
        productPriceAfter: "\$305",
        productPriceBefore: "\$455",
        productName: "Product name"
      ),);
    newProductName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name"
      ),);
    newProductName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Woman T-Shirt"
      ),);
  }

  //Trending Product Images
  List<String> trendingProductsImage = [Utils.getAssetsHomeImg('trending_product_first'), Utils.getAssetsHomeImg('trending_product_second'), Utils.getAssetsHomeImg('product_name_third'),];

  //Trending Product List of data
  trendingProductsData() {
    trendingProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name"
      ),);
    trendingProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name"
      ),);
    trendingProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Woman T-Shirt"
      ),);
  }

  //Featured Product Images
  List<String> featuredProductsImage = [Utils.getAssetsHomeImg('featured_product_first'), Utils.getAssetsHomeImg('featured_product_second'), Utils.getAssetsHomeImg('product_name_third'),];

  //Featured Product List of data
  featuredProductsData() {
    featuredProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name"
      ),);
    featuredProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Product name"
      ),);
    featuredProductsName.add(HomeScreenModel(
          productPriceAfter: "\$305",
          productPriceBefore: "\$455",
          productName: "Woman T-Shirt"
      ),);
  }

}
