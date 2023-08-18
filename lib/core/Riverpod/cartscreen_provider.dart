import 'package:coffeeproject/core/Model/productmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartscreenprovider =
    StateNotifierProvider<CartScreenNotifier, List<Product>>(
        (ref) => CartScreenNotifier());

class CartScreenNotifier extends StateNotifier<List<Product>> {
  CartScreenNotifier([List<Product>? intialTodos]) : super(intialTodos ?? []);
  // final firebaseservice = Firebaseservice();

  void addProducttocartlistdb(Product product) {
    state = [...state, product];
    //  firebaseservice.addproducttofirestore(product);
  }

  void removeproductfromdb(Product product) async {
    state = state.where((element) => element.id != product.id).toList();
    // await isarservice.deletetaskfromisar(task);
  }

  void updatedtask(Product product) async {
    List<Product> newlist = [...state];
    int index = newlist.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      newlist[index] = product;
    }
    state = newlist;
  }
}
