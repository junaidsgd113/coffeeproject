

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category/category.dart';
import '../Service/firebase_service.dart';


final categoryScreenProvider =
    StateNotifierProvider<CategoryScreenNotifier, List<Category>>(
        (ref) => CategoryScreenNotifier());

class CategoryScreenNotifier extends StateNotifier<List<Category>> {
  CategoryScreenNotifier([List<Category>? intialTodos])
      : super(intialTodos ?? []);
  final firebaseservice = Firebaseservice();

  void addCategory(Category category) {
    state = [...state, category];
      firebaseservice.addCategoryToDB(category);
  }

  void deletCategory(Category category) async {
    state = state.where((element) => element.id != category.id).toList();
  await firebaseservice.deleteCategoryFromDB(category);
  }
  Future<void> fetchCategorys()async{
    state=await firebaseservice.fetchCategorysFromDB();
  }

  // void updatedtask(Product product) async {
  //   List<Product> newlist = [...state];
  //   int index = newlist.indexWhere((element) => element.id == product.id);
  //   if (index != -1) {
  //     newlist[index] = product;
  //   }
  //   state = newlist;
  // }
}
