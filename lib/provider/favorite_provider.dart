import 'package:cyber/product_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider = 
StateNotifierProvider<ProductListNotifierProvider, List<Map<String,dynamic>>>((ref)=> ProductListNotifierProvider());

class ProductListNotifierProvider extends StateNotifier<List<Map<String,dynamic>>>{
  ProductListNotifierProvider():super(
    [...productData['items']! as List].map((item) => Map<String, dynamic>.from(item as Map)).toList(),
  );

  void favoriteChange(int index){
    final favoriteUpdate = [...state];
    favoriteUpdate[index]['is_favorite'] = !(favoriteUpdate[index]['is_favorite'] as bool);
    state = favoriteUpdate;
  }
}
