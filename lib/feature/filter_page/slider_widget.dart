import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceRangeNotifier extends StateNotifier<RangeValues>{
  PriceRangeNotifier():super(const RangeValues(1000, 1300));

  void updateRange(RangeValues values) {
    state = values;
  }
}
final priceRangeProvider = StateNotifierProvider<PriceRangeNotifier,RangeValues>((ref) {return PriceRangeNotifier();
});

class PriceSlider extends ConsumerWidget {
  const PriceSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(priceRangeProvider);
    final controllerFrom = TextEditingController(text: range.start.toInt().toString());
    final controllerTo = TextEditingController(text: range.end.toInt().toString());
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controllerFrom,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'From',border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: controllerTo,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'To',border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
        ),
        RangeSlider(
          values: range,
          min: 0,
          max: 2000,
          divisions: 100,
          labels: RangeLabels(
            range.start.round().toString(),
            range.end.round().toString(),
          ),
          onChanged: (values) {
            ref.read(priceRangeProvider.notifier).updateRange(values);
          },
        ),
      ],
    );
  }
}