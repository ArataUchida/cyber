import 'package:flutter/material.dart';

///filter_pageの値を保持するためのモデルクラス
final class SelectedFilter {
  final String? keyword;
  final RangeValues? values;
  final List<String>? storage;

  const SelectedFilter({
    this.keyword,
    this.values,
    this.storage,
  });

  SelectedFilter copyWith({
    String? keyword,
    RangeValues? values,
    List<String>? storage

  }){
    return SelectedFilter(
      keyword: keyword ?? this.keyword,
      values: values ?? this.values,
      storage: storage ?? this.storage
      );
  }
}