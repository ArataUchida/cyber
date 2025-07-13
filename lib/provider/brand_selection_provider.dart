import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ブランドリスト
const brandList = [
  'Apple',
  'Samsung',
  'Xiaomi',
  'Poco',
  'OPPO',
  'Honor',
  'Motorola',
  'Nokia',
  'Realme',
];

class BrandSelectionNotifier extends StateNotifier<Map<String, bool>> {
  BrandSelectionNotifier()
      : super({for (final brand in brandList) brand: false});

  void toggle(String brand, {required bool selected}) {
    state = {
      ...state,
      brand: selected,
    };
  }

  void reset() {
    state = {for (final brand in brandList) brand: false};
  }
}

final brandSelectionProvider =
    StateNotifierProvider<BrandSelectionNotifier, Map<String, bool>>(
        (ref) => BrandSelectionNotifier(),);

final brandSearchProvider = StateProvider<String>((ref) => '');
