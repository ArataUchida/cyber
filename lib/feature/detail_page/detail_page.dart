import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber/feature/shopping_cart_page/shopping_cart_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cyber/feature/shopping_cart_page/shopping_cart_page.dart';
import 'package:cyber/product_detail_data.dart'; 

final selectedColorProvider = StateProvider<Color>((ref) => Colors.black);
final selectedStorageProvider = StateProvider<String>((ref) => '1TB');

class ProductDetailPage extends ConsumerWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(selectedColorProvider);
    final selectedStorage = ref.watch(selectedStorageProvider);

    final colors = [Colors.black, Colors.purple, Colors.red, Colors.yellow, Colors.white];
    final storages = List<String>.from(productDetailData[0]['product_storage'] as List<dynamic>);

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              productDetailData[0]['thumbnail'] as String,
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10),

            Text(productDetailData[0]['product_name'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            const Text('Select color :'),
            Row(
              children: colors.map((color) {
                final isSelected = color == selectedColor;
                return GestureDetector(
                  onTap: () => ref.read(selectedColorProvider.notifier).state = color,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected ? Border.all(width: 3, color: Colors.blue) : null,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: storages.map((storage) {
                final isSelected = storage == selectedStorage;
                return ChoiceChip(
                  label: Text(storage),
                  selected: isSelected,
                  onSelected: (_) => ref.read(selectedStorageProvider.notifier).state = storage,
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Text('\$${productDetailData[0]['product_price']}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Text('\$1499', style: TextStyle(decoration: TextDecoration.lineThrough)),
              ],
            ),

            const SizedBox(height: 20),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                SpecTile(icon: Icons.smartphone, label: 'Screen size', value: '${productDetailData[0]['product_screenSize']}"'),
                SpecTile(icon: Icons.memory, label: 'CPU', value: productDetailData[0]['product_cpu'] as String),
                SpecTile(icon: Icons.blur_circular, label: 'Cores', value: '${productDetailData[0]['product_numberOfCores']}'),
                SpecTile(icon: Icons.camera_alt, label: 'Main', value: productDetailData[0]['product_mainCamera'] as String),
                SpecTile(icon: Icons.camera_front, label: 'Front', value: productDetailData[0]['product_FrontCamera'] as String),
                SpecTile(icon: Icons.battery_full, label: 'Battery', value: productDetailData[0]['product_batteryCapacity'] as String),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Enhanced capabilities thanks to an enlarged display of 6.7 inches and work without recharging throughout the day. Incredible photos in weak, bright lighting using the new system with two cameras.',
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                child: const Text('Add to Wishlist'),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Add to Cart'),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                InfoColumn(icon: Icons.local_shipping, label: 'Free Delivery', value: '1-2 day'),
                InfoColumn(icon: Icons.store, label: 'In Stock', value: 'Today'),
                InfoColumn(icon: Icons.verified, label: 'Guaranteed', value: '1 year'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SpecTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SpecTile({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoColumn({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
