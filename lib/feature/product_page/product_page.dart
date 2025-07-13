import 'package:cyber/feature/product_page/product_search_widget.dart';
import 'package:cyber/feature/product_page/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/Logo.png',
            width: 100,
            height: 40,
          ),
        ),
      ),
      endDrawer: const Drawer(),
      body: const Column(
        children: [
          // Filters By rating
          ProductSearchWidget(),
          SizedBox(height: 20),

          // product
          Expanded(
            child: ProductWidget(), 
          ),
        ],
      ),
    );
  }
}
