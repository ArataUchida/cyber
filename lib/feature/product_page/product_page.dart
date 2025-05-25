import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber/feature/product_page/product_search_widget.dart';
import 'package:cyber/feature/product_page/product_widget.dart';
import 'package:cyber/feature/product_page/pagination_widget.dart';
import 'package:cyber/provider/pagination_provider.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);

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
      endDrawer: Drawer(),
      body: Column(
        children: [
          // Filters By rating
          const ProductSearchWidget(),
          const SizedBox(height: 20),

          // product
          const Expanded(
            child: ProductWidget(), 
          ),

          // PageWidget
          PaginationWidget(
            currentPage: currentPage,
            totalPages: 12,
            onPageChanged: (page) {
              ref.read(currentPageProvider.notifier).state = page;
            },
          ),
        ],
      ),
    );
  }
}