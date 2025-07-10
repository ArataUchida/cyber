import 'package:cyber/feature/shopping_cart_page/shopping_cart_page.dart';
import 'package:cyber/product_detail_data.dart';
import 'package:cyber/provider/shopping_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

final selectedColorProvider = StateProvider<Color?>((ref) => null);
final selectedStorageProvider = StateProvider<String>((ref) => '1TB');
final productIdProvider = StateProvider<int>((ref) => 0);

class ProductDetailPage extends ConsumerWidget { 
  //final int product_Id; 5
  const ProductDetailPage({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(selectedColorProvider);
    final selectedStorage = ref.watch(selectedStorageProvider);
    final productId = ref.watch(productIdProvider);
    //final baseProduct = productDetailData.firstWhere((item) => item['product_id'] == productId,
    //      orElse: ()=> productDetailData.first,
    //);
    final colorsName = List<String>.from(productDetailData[index]["product_color"] as List<dynamic>);
    //final colorsName = List<String>.from(baseProduct['product_color']! as List<dynamic>);
    final colors = colorsName.map(colorFromName).toList();
    // 選ばれた色の商品を探す
    final product = productDetailData.firstWhere(
      (item) => colorFromName(item['color'] as String) == selectedColor,
      orElse: () => productDetailData[index],
    );
    final storages = List<String>.from(productDetailData[index]['product_storage'] as List<dynamic>);
    //final storages = List<String>.from(baseProduct['product_storage']! as List<dynamic>);
    //final product = productDetailData.firstWhere(
    //  (item) => item['product_id'] == productId &&
    //    colorFromName(item['color'] as String) == selectedColor,
    //  orElse: () => baseProduct,
    //);

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
              productDetailData[index]['thumbnail'] as String,
              //product['thumbnail'] as String,
              //baseProduct['thumbnail']! as String,
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
            ),
            
            const SizedBox(height: 10),

            Text(productDetailData[index]['product_name'] as String, 
            style: const TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.bold
              )
            ),

            const SizedBox(height: 10),

            const Text('Select color :'),
            Row(
              children: colors.map((color) {
                final isSelected = color == selectedColor;
                return GestureDetector(
                  //onTap: () => ref.read(selectedColorProvider.notifier).state = color,
                  onTap: () {
                    final currentProductId = ref.watch(productIdProvider);
                    // このIDに基づいて現在の商品を表示
                    final product = productDetailData.firstWhere(
                      (item) => item['product_id'] == currentProductId,
                    );
                     //カラー選択時に、その色に対応する商品を探す
                    //final newProduct = productDetailData.firstWhere(
                    //  (item) => item['color'] == color,
                    //  orElse: () => baseProduct,
                    //);
                    //final newProduct = productDetailData.firstWhere(
                    //  (item) => colorFromName(item['color']! as String) == color, 
                    //  //orElse: () => baseProduct,
                    //);
                     //ここで product_id を切り替え
                    ref.read(productIdProvider.notifier).state = product['product_id']! as int;
                     //色の状態も更新（選択ハイライトのため）
                    ref.read(selectedColorProvider.notifier).state = color;
                  },   
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
                Text('\$${productDetailData[index]['product_price']}', 
                  style: const TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold
                  )
                ),
                const SizedBox(width: 8),
                const Text(r'$1499', style: TextStyle(decoration: TextDecoration.lineThrough)),
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
                SpecTile(icon: Icons.smartphone, label: 'Screen size', value: '${productDetailData[index]['product_screenSize']}"'),
                SpecTile(icon: Icons.memory, label: 'CPU', value: productDetailData[index]['product_cpu'] as String),
                SpecTile(icon: Icons.blur_circular, label: 'Cores', value: '${productDetailData[index]['product_numberOfCores']}'),
                SpecTile(icon: Icons.camera_alt, label: 'Main', value: productDetailData[index]['product_mainCamera'] as String),
                SpecTile(icon: Icons.camera_front, label: 'Front', value: productDetailData[index]['product_FrontCamera'] as String),
                SpecTile(icon: Icons.battery_full, label: 'Battery', value: productDetailData[index]['product_batteryCapacity'] as String),
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
                  final cartItem = CartItem(
                    name: productDetailData[index]['product_name'] as String,
                    thumbnail: productDetailData[index]["thumbnail"] as String,
                    price: productDetailData[index]['product_price'] as int,
                  );
                  ref.read(cartProvider.notifier).addToCart(cartItem);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
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

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoColumn(icon: Icons.local_shipping, label: 'Free Delivery', value: '1-2 day'),
                InfoColumn(icon: Icons.store, label: 'In Stock', value: 'Today'),
                InfoColumn(icon: Icons.verified, label: 'Guaranteed', value: '1 year'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class SpecTile extends StatelessWidget {

  const SpecTile({required this.icon, required this.label, required this.value, super.key});
  final IconData icon;
  final String label;
  final String value;

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

  const InfoColumn({required this.icon, required this.label, required this.value, super.key});
  final IconData icon;
  final String label;
  final String value;

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

Color colorFromName (String colorName){
  switch (colorName.toLowerCase()) {
    case 'black':
      return Colors.black;
    case 'purple':
      return Colors.purple;
    case 'yellow':
      return Colors.yellow;
    case 'red':
      return Colors.red;
    case 'white':
      return Colors.white;
    default :
      return Colors.white;
  }
}