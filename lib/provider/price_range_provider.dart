import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceRangeNotifier extends StateNotifier<RangeValues>{
  PriceRangeNotifier():super(const RangeValues(0, 2000));

  void updateRange(RangeValues values) {
    state = values;
  }
}
final priceRangeProvider = StateNotifierProvider<PriceRangeNotifier,RangeValues>((ref) {return PriceRangeNotifier();
});
