import 'package:cyber/feature/detail_page/detail_page.dart';
import 'package:cyber/product_data.dart';
import 'package:cyber/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductWidget extends ConsumerStatefulWidget {
  const ProductWidget({super.key});

  @override
  ConsumerState<ProductWidget> createState() => _ProductWidgetState();
}
class _ProductWidgetState extends ConsumerState<ProductWidget> {
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> products = [];
  bool _isLoadingMore = false;
  int _currentPage = 0;
  late Future<void> _initialLoad;

  @override
  void initState() {
    super.initState();
    _initialLoad = _fetchInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchInitialProducts() async {
    final newItems = await futureProducts(_currentPage);
    products.addAll(newItems);
  }

  Future<List<Map<String, dynamic>>> futureProducts(int page) async {
    final items = (productData['items']! as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();
    final startItem = page * 4;
    if (startItem >= items.length) return [];
    final endItem = (startItem + 4).clamp(0, items.length);
    return items.sublist(startItem, endItem);
  }

  Future<void> fetchMore() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    await Future<void>.delayed(const Duration(seconds: 1));
    _currentPage++;
    final addItems = await futureProducts(_currentPage);

    if (addItems.isNotEmpty) {
      setState(() {
        products.addAll(addItems);
      });
    }

    setState(() => _isLoadingMore = false);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore) {
      fetchMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteItems = ref.watch(favoriteProvider);

    return FutureBuilder<void>(
      future: _initialLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Result: $productLength',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  controller: _scrollController,
                  itemCount: products.length + (_isLoadingMore ? 1 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.50,
                  ),
                  itemBuilder: (context, index) {
                    if (index == products.length) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final product = products[index];
                    final isFavorite = favoriteItems.length > index &&
                        (favoriteItems[index]['is_favorite'] as bool);

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(favoriteProvider.notifier)
                                    .favoriteChange(index);
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product['product_thumbnail'].toString(),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: 120,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product['product_name'].toString(),
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
                                  MaterialPageRoute<Widget>(
                                    builder: (context) =>
                                        ProductDetailPage(index: index),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
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
        );
      },
    );
  }
}
