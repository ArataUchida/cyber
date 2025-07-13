import 'package:cyber/provider/price_range_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceSlider extends ConsumerWidget {
  const PriceSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(priceRangeProvider);
    final controllerFrom = TextEditingController(text: range.start.toInt().toString());
    final controllerTo = TextEditingController(text: range.end.toInt().toString());

    void updateRangeFromText(){
      final from = int.tryParse(controllerFrom.text);
      final to = int.tryParse(controllerTo.text);
      if(from != null && to !=null && from <= to && to <= 2000){
        ref.read(priceRangeProvider.notifier)
        .updateRange(RangeValues(from.toDouble(),to.toDouble()));
      }
    }

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
                  decoration: const InputDecoration(labelText: 'From',border: OutlineInputBorder()),
                  onSubmitted: (_) => updateRangeFromText(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: controllerTo,
                  decoration: const InputDecoration(labelText: 'To',border: OutlineInputBorder()),
                  onSubmitted: (_) => updateRangeFromText(),
                ),
              ),
            ],
          ),
        ),
        RangeSlider(
          values: range,
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
