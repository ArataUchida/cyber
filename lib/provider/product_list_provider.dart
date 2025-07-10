import 'package:cyber/product_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///product_widgetの状態管理　productListProvider
final productListProvider = 
  StateNotifierProvider<ProductListNotifier, List<Map<String, dynamic>>>(
  (ref) => ProductListNotifier(),
);

///データを追加読み込み中かどうかを管理する フラグ用プロバイダ
final isLoadingMoreProvider = StateProvider<bool>((ref) => false);

///product_widgetの状態管理クラス
class ProductListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  int _currentPage = 0;
  final int _limit = 4;

  ///最初に状態は空のリストを設定（コンストラクタ）
  ProductListNotifier() : super([]) {
    fetchInitial();
  }

  ///初期データを読み込む（１ページ目）
  void fetchInitial() {
    state = _fetchPage(0);
  }

  ///fetchMore() 関数は、すでに読み込み中かどうかを「isLoadingMoreProvider」を通して確認し、
  ///もし読み込み中であれば、それ以上のデータ取得処理を行わずに終了。
  ///これにより、同時に複数回の読み込みが発生することを防止。
  Future<void> fetchMore(WidgetRef ref) async {
    if (ref.read(isLoadingMoreProvider)) return;

    ref.read(isLoadingMoreProvider.notifier).state = true;

    await Future.delayed(const Duration(seconds: 2));

    _currentPage++;
    final newItems = _fetchPage(_currentPage);

    state = [...state, ...newItems];
    ref.read(isLoadingMoreProvider.notifier).state = false;
  }

  List<Map<String, dynamic>> _fetchPage(int page) {
    final items = (productData['items']! as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();

    final start = page * _limit;
    final end = (start + _limit).clamp(0, items.length);

    return start < items.length ? items.sublist(start, end) : [];
  }
}