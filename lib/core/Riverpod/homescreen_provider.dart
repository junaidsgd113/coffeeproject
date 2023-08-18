import 'package:coffeeproject/core/Model/productmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Service/firebase_service.dart';




final homescreenprovider =
    StateNotifierProvider< HomeScreenNotifier, List<Product>>((ref) =>  HomeScreenNotifier());


class HomeScreenNotifier
 extends StateNotifier<List<Product>> {
   HomeScreenNotifier([List<Product>? intialTodos]) : super(intialTodos ?? []);
 final firebaseservice = Firebaseservice();

  void addProduct(Product product) {
    state = [...state, product];
  firebaseservice.addproducttofirestore(product);
  }

 Future<void> fetchtaskfromfirestoredb( {String? query}) async{
    state=await firebaseservice.fetchproductsFromFirebase();
  if(query!.isEmpty){
        state=await firebaseservice.fetchproductsFromFirebase();
 
  }else{
  
     state=await firebaseservice.searchproducts(query);
  }

 }

  void deleteproductfromdb(Product product) async {
    state = state.where((element) => element.id != product.id).toList();
    await firebaseservice.deleteproductfromdb(product);
  }
//  Future<void> searchproducts(String query ) async{
  
//   state=await firebaseservice.searchproducts(query);
//  }

  // void updatedtask(Product product) async {
  //   List<Product> newlist = [...state];
  //   int index = newlist.indexWhere((element) => element.id == product.id);
  //   if (index != -1) {
  //     newlist[index] = product;
  //   }
  //   state = newlist;
    
  // }

  
}
