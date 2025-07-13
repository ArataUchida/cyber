class CartItem {

  CartItem({
    required this.productId,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['product_id']as int,
        name: json['name'].toString(),
        thumbnail: json['thumbnail'].toString(),
        price: json['price']as int,
        quantity: json['quantity']as int,
      );
  final int productId;
  final String name;
  final String thumbnail;
  final int price;
  final int quantity;
}

class OrderSummary {

  OrderSummary({
    required this.subtotal,
    required this.estimatedTax,
    required this.estimatedShipping,
    required this.total,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        subtotal: json['subtotal']as int,
        estimatedTax: json['estimated_tax'] as int,
        estimatedShipping: json['estimated_shipping']as int,
        total: json['total']as int,
      );
  final int subtotal;
  final int estimatedTax;
  final int estimatedShipping;
  final int total;
}
