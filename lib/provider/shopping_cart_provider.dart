import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String name;
  final String thumbnail;
  final int price;
  int quantity;

  CartItem({
    required this.name,
    required this.thumbnail,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      name: name,
      thumbnail: thumbnail,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>>{
  CartNotifier() : super([]);
  void addToCart(CartItem newItem) {
    final index = state.indexWhere((item) => item.name == newItem.name);
    if (index != -1) {
      final updatedItem = state[index].copyWith(quantity: state[index].quantity + 1);
      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      state = [...state, newItem];
    }
  }

  void removeFromCart(CartItem item) {
    state = state.where((i) => i.name != item.name).toList();
  }

  void clearCart() {
    state = [];
  }

   void increaseQuantity(CartItem item) {
    state = [
      for (final i in state)
        if (i.name == item.name)
          i.copyWith(quantity: i.quantity + 1)
        else
          i
    ];
  }

  void removeItem(CartItem item) {
  state = state.where((i) => i.name != item.name).toList();
}

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      state = [
        for (final i in state)
          if (i.name == item.name)
            i.copyWith(quantity: i.quantity - 1)
          else
            i
      ];
    }
  }
}
