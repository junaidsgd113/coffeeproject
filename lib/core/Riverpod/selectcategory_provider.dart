import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategoryStateNotifier, String>(
        (ref) => SelectedCategoryStateNotifier());

class SelectedCategoryStateNotifier extends StateNotifier<String> {
  SelectedCategoryStateNotifier() : super('Arabica'); // Initial value

  void setSelectedCategory(String newValue) {
    state = newValue;
  }
}
