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

  void toggle(String memory, {required bool selected}) {
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
        (ref) => MemorySelectionNotifier(),);

/// 検索文字列の状態を保持
final memorySearchProvider = StateProvider<String>((ref) => '');
