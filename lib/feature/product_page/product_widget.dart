import 'package:flutter/material.dart';
import 'package:cyber/product_data.dart';
import 'package:cyber/feature/detail_page/detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber/provider/favorite_provider.dart';

//final favoriteProvider = StateProvider<bool>((ref)=> false);

class ProductWidget extends ConsumerWidget {
  ProductWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> items = (productData['items'] as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();

    final int totalCount = productData['totalCount'] as int;

    //final isFavorited = ref.watch(favoriteProvider);
    final favoriteItems = ref.watch(favoriteProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Result: $totalCount',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.50,
                ),
                itemBuilder: (context, index) {
                  final product = favoriteItems[index];
                  final bool isFavorited = product["is_favorite"] as bool;
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 244, 244),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () { 
                              ref.read(favoriteProvider.notifier).favoriteChange(index);
                            },
                            icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: isFavorited ? Colors.red :Colors.grey,
                            ),
                            color:  Colors.red,
                          ),
                        ),
                        ClipRRect(
                          child: Image.asset(
                            product['product_thumbnail'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 120,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['product_name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\$${product['product_price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(index:index)
                                )
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}