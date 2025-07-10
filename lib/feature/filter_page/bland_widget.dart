import 'package:flutter/material.dart';
import 'package:cyber/provider/brand_selection_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandFilterWidget extends ConsumerWidget {
  const BrandFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(brandSearchProvider);
    final selectedBrands = ref.watch(brandSelectionProvider);

    // フィルターされたブランドリスト
    final filteredBrands = brandList
        .where((brand) =>
            brand.toLowerCase().contains(searchText.toLowerCase()),)
        .toList();

    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) =>
                ref.read(brandSearchProvider.notifier).state = value,
          ),
        ),
        const SizedBox(height: 10),
        ...filteredBrands.map(
          (brand) => CheckboxListTile(
            value: selectedBrands[brand] ?? false,
            onChanged: (checked) {
              ref
                  .read(brandSelectionProvider.notifier)
                  .toggle(brand, checked ?? false);
            },
            title: Text(brand),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ],
    );
  }
}