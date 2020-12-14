class ProductModel{
  String productName;
  String productId;
  List<String> productUrl;
  int oldPrice;
  int newPrice;
  String size;
  String description;
  List<String> colors;

  ProductModel(
      {this.productName,
      this.productUrl,
      this.oldPrice,
        this.productId,
      this.newPrice,
      this.size,
      this.description,
      this.colors});
}