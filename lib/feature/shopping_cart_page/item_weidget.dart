class CartItem {
  final int productId;
  final String name;
  final String thumbnail;
  final int price;
  final int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['product_id'],
        name: json['name'],
        thumbnail: json['thumbnail'],
        price: json['price'],
        quantity: json['quantity'],
      );
}

class OrderSummary {
  final int subtotal;
  final int estimatedTax;
  final int estimatedShipping;
  final int total;

  OrderSummary({
    required this.subtotal,
    required this.estimatedTax,
    required this.estimatedShipping,
    required this.total,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        subtotal: json['subtotal'],
        estimatedTax: json['estimated_tax'],
        estimatedShipping: json['estimated_shipping'],
        total: json['total'],
      );
}