class CartModel {
  CartModel({
    this.oldPrice,
    this.newPrice,
    this.productName,
    this.imageUrl,
    this.productCode,
    this.quantity = 1
  });

  String oldPrice;
  String newPrice;
  String productName;
  String productCode;
  String imageUrl;
  int quantity;
}