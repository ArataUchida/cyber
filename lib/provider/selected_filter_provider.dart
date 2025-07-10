import 'package:cyber/models/selected_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFilterNotifier extends StateNotifier<SelectedFilter>{
  SelectedFilterNotifier():super(const SelectedFilter());

  void setKeyWord(String? keyword){
    state = state.copyWith(keyword: keyword);
  }

  void setValues(RangeValues? values){
    state = state.copyWith(values: values);
  }

  void setStorage(List<String>? storage){
    state = state.copyWith(storage: storage);
  }
}

final SelectedFilterProvider = 
      StateNotifierProvider<SelectedFilterNotifier,SelectedFilter>(
        (ref) => SelectedFilterNotifier()
      );