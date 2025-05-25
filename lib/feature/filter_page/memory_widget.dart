import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// メモリ容量の一覧
const memoryOptions = [
  '16GB',
  '32GB',
  '64GB',
  '128GB',
  '256GB',
  '512GB',
];

/// メモリの選択状態を保持する StateNotifier
class MemorySelectionNotifier extends StateNotifier<Map<String, bool>> {
  MemorySelectionNotifier()
      : super({for (final mem in memoryOptions) mem: false});

  void toggle(String memory, bool selected) {
    state = {
      ...state,
      memory: selected,
    };
  }

  void reset() {
    state = {for (final mem in memoryOptions) mem: false};
  }
}

final memorySelectionProvider =
    StateNotifierProvider<MemorySelectionNotifier, Map<String, bool>>(
        (ref) => MemorySelectionNotifier());

/// 検索文字列の状態を保持
final memorySearchProvider = StateProvider<String>((ref) => '');

/// ウィジェット本体
class MemoryFilterWidget extends ConsumerWidget {
  const MemoryFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(memorySearchProvider);
    final memorySelection = ref.watch(memorySelectionProvider);

    final filteredMemoryOptions = memoryOptions
        .where((mem) => mem.toLowerCase().contains(searchText.toLowerCase()))
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
            ),
            onChanged: (value) =>
                ref.read(memorySearchProvider.notifier).state = value,
          ),
        ),
        const SizedBox(height: 10),
        ...filteredMemoryOptions.map(
          (memory) => CheckboxListTile(
            value: memorySelection[memory] ?? false,
            onChanged: (checked) {
              ref
                  .read(memorySelectionProvider.notifier)
                  .toggle(memory, checked ?? false);
            },
            title: Text(memory),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ],
    );
  }
}