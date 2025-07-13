import 'package:cyber/provider/memory_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              fillColor: Colors.white,
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
                  .toggle(memory, selected: checked ?? false);
            },
            title: Text(memory),
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ),
      ],
    );
  }
}
