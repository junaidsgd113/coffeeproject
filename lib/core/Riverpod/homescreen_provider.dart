import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Service/firebase_service.dart';
import '../models/product/product.dart';

final homeScreenProvider =
    StateNotifierProvider<HomeScreenNotifier, List<Product>>(
        (ref) => HomeScreenNotifier());

class HomeScreenNotifier extends StateNotifier<List<Product>> {
  HomeScreenNotifier([List<Product>? intialTodos]) : super(intialTodos ?? []);
  final firebaseservice = Firebaseservice();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _productcollection = 'products';

  get length => null;
  void addProduct(Product product) {
    state = [...state, product];
    firebaseservice.addProductsToDB(product);
  }

  Future<void> fetchProducts() async {
    state = await firebaseservice.fetchProductsFromDB();
  }

  void deleteProducts(Product product) async {
    state = state.where((element) => element.id != product.id).toList();
    await firebaseservice.deleteProductsFromDB(product);
  }

  Future<void> searchProducts(String query) async {
    try {
      var snapshot = await _db
          .collection(_productcollection)
          .where('category', isEqualTo: query.toLowerCase())
          .get();

      state = snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updatedProduct(Product product) async {
    List<Product> newlist = [...state];
    int index = newlist.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      newlist[index] = product;
    }
    state = newlist;
    await firebaseservice.updateProductsFromDB(product);
  }
}
