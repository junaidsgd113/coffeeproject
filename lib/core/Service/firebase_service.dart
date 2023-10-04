import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

import '../models/category/category.dart';

import '../models/product/product.dart';


class Firebaseservice {
  final _db = FirebaseFirestore.instance;
  final String soldproductcollection = 'soldproducts';
  final String _productcollection = 'products';
  final String _categorycollection = 'category';
  final String _soldProductCollectionYearly = 'FinanceDetailofsoldProducts';
  Future<void> addProductsToDB(Product product) async {
    await _db
        .collection(_productcollection)
        .doc(product.id)
        .set(product.toJson());
  }

  Future<List<Product>> fetchProductsFromDB() async {
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

  Future<void> deleteProductsFromDB(Product product) async {
    await _db.collection(_productcollection).doc(product.id).delete();
  }

  Future<void> updateProductsFromDB(Product product) async {
    await _db
        .collection(_productcollection)
        .doc(product.id)
        .update(product.toJson());
  }

  ////////////////////////category/////////////////////////////////////////////////////////////
  Future<void> addCategoryToDB(Category category) async {
    await _db
        .collection(_categorycollection)
        .doc(category.id)
        .set(category.toJson());
  }

  Future<List<Category>> fetchCategorysFromDB() async {
    try {
      List<Category> categorylist = [];
      var snapshot = await _db.collection(_categorycollection).get();
      for (var data in snapshot.docs) {
        categorylist.add(Category.fromJson(data.data()));
      }

      return categorylist;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteCategoryFromDB(Category category) async {
    await _db.collection(_categorycollection).doc(category.id).delete();
  }

///////////////////////////////dashboard///////////////////////////////////////////////////

  Future<void> addSoldProductToDB(
    Product product,
  ) async {
    DateTime date = DateTime.now();
    await _db
        .collection(soldproductcollection)
        .doc(DateFormat('yyyy').format(date))
        .collection(DateFormat('MM').format(date))
        .doc(product.id)
        .set(product.toJson());
  }

  Future<List<Product>> fetchSoldProductFromDB() async {
    List<Product> soldProductList = [];
    DateTime date = DateTime.now();
    var snapshot = await _db
        .collection(soldproductcollection)
        .doc(DateFormat('yyyy').format(date))
        .collection(DateFormat('MM').format(date))
        .get();

    for (var data in snapshot.docs) {
      soldProductList.add(Product.fromJson(data.data()));
    }
   
    return soldProductList;
  }

  Future<void> updateSoldProductQuantity(
      String productid, int newQuantity) async {
    DateTime date = DateTime.now();
    final productDocRef = _db
        .collection(soldproductcollection)
        .doc(DateFormat('yyyy').format(date))
        .collection(DateFormat('MM').format(date))
        .doc(productid);
    await _db.collection(_productcollection).doc(productid).update({
      "soldquantity": newQuantity,
    });
    await productDocRef.update({'soldquantity': newQuantity});
  }

  Future<void> updateDateSoldProductsFromDB(
    String productId,
    DateTime newdate,
  ) async {
    DateTime date = DateTime.now();
    await _db
        .collection(soldproductcollection)
        .doc(DateFormat('yyyy').format(date))
        .collection(DateFormat('MM').format(date))
        .doc(productId)
        .update({'timestamp': newdate});
  }

  Future<List<Product>> fetchDataFromDBMM(DateTime selectMonth) async {
    List<Product> soldProductList = [];

    var snapshot = await _db
        .collection(soldproductcollection)
        .doc(DateFormat('yyyy').format(selectMonth))
        .collection(DateFormat('MM').format(selectMonth))
        .get();

    for (var data in snapshot.docs) {
      Timestamp timestamp = data['timestamp'];
      DateTime docdate = timestamp.toDate();
      if (docdate.year == selectMonth.year &&
          docdate.month == selectMonth.month) {
        soldProductList.add(Product.fromJson(data.data()));
      }
    }
    print(soldProductList);
    return soldProductList;
  }

  Future<List<Product>> fetchDataInRangeFromDB(
      DateTime startDate, DateTime endDate) async {
    List<Product> soldProductList = [];
    DateTime date = DateTime.now();
    var snapshot = await _db
        .collection(soldproductcollection)
        .doc(DateFormat('yyyy').format(date))
        .collection(DateFormat('MM').format(date))
        .orderBy('timestamp')
        .startAt([Timestamp.fromDate(startDate)]).endAt(
            [Timestamp.fromDate(endDate)]).get();

    for (var data in snapshot.docs) {
      soldProductList.add(Product.fromJson(data.data()));
    }
    print(soldProductList);
    return soldProductList;
  }
/////////////////////////////////filter Data for financialdetails sfCartesiangrapg///////////////////
/////////////////FinanceDetailofsoldProducts//////////////////////////

  Future<void> addSoldProductToDBYearCollection( Product product) async {
    await _db
        .collection(_soldProductCollectionYearly)
        .doc(product.id)
        .set(product.toJson());
  }

  Future<List<Product>> fetchSoldProductFromYearCollectionDB(DateTime selectYear) async {
    List<Product> soldproductlist = [];

    var snapshot = await _db.collection(_soldProductCollectionYearly).get();
    for (var data in snapshot.docs) {
      Timestamp timestamp = data['timestamp'];
      DateTime docdate = timestamp.toDate();
      if (docdate.year == selectYear.year) {
        soldproductlist.add(Product.fromJson(data.data()));
      }
    }

    return soldproductlist;
  }
   Future<void> updateSoldProductQuantityYearCollection( String productid, int newQuantity) async {
   
    final productDocRef = _db
        .collection(soldproductcollection)
        
        .doc(productid);
    await _db.collection(_productcollection).doc(productid).update({
      "soldquantity": newQuantity,
    });
    await productDocRef.update({'soldquantity': newQuantity});
  }

  Future<void> updateDateSoldProductsFromYearCollectionDB(String productId,DateTime newdate, ) async {

    await _db
        .collection(soldproductcollection)
        
        .doc(productId)
        .update({'timestamp': newdate});
  }
}
