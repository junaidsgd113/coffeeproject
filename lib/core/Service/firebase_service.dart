import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/productmodel.dart';

class Firebaseservice {
  final _db = FirebaseFirestore.instance;

  final String _productcollection = 'coffee';
  Future<void> addproducttofirestore(Product product) async {
    await _db
        .collection(_productcollection)
        .doc(product.id)
        .set(product.toJson());
  }

  Future<List<Product>> fetchproductsFromFirebase() async {
    try {
      List<Product> productlist = [];
      var snapshot = await _db.collection(_productcollection).get();
      for (var data in snapshot.docs) {
        productlist.add(Product.fromJson(data.data()));
      }

      return productlist;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteproductfromdb(Product product) async {
    await _db.collection(_productcollection).doc(product.id).delete();
  }

  Future<List<Product>> searchproducts(String query) async {
    List<Product> searchlist = [];
   // String queryLower = query.toLowerCase();
   // String queryUpper = query.toUpperCase();
    // var collectionReference = _db.collection(_productcollection);
    var snapshot = await _db.collection(_productcollection)
        .where('category', isEqualTo: query)
        
        .get();
    for (var data in snapshot.docs) {
      searchlist.add(Product.fromJson(data.data()));
    }
    return searchlist;
  }

}
