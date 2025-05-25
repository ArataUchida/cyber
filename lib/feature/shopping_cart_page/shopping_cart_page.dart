import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber/feature/shopping_cart_page/item_weidget.dart';
import 'package:cyber/shopping_cart_data.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems = (shoppingCartData['cart_items'] as List)
      .map((item) => CartItem.fromJson(item))
      .toList();

  final OrderSummary orderSummary =
      OrderSummary.fromJson(shoppingCartData['order_summary'] as Map<String,dynamic>);

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/Logo.png',
            width: 100,
            height: 40,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Shopping Cart', style:  TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          ...cartItems.map((item) => Card(
                child: ListTile(
                  leading: Image.asset(item.thumbnail, width: 70),
                  title: Text(item.name),
                  subtitle: Text("Quantity: ${item.quantity}"),
                  trailing: Text("\$${item.price}"),
                ),
              )),
          const SizedBox(height: 24),
          const Text("Order Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildSummaryRow("Subtotal", orderSummary.subtotal),
          _buildSummaryRow("Estimated Tax", orderSummary.estimatedTax),
          _buildSummaryRow("Shipping", orderSummary.estimatedShipping),
          const Divider(),
          _buildSummaryRow("Total", orderSummary.total, isBold: true),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Checkout"),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, int amount, {bool isBold = false}) {
    final style = TextStyle(
      fontSize: 16,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text("\$$amount", style: style),
        ],
      ),
    );
  }
}
        