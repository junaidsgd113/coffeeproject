import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Service/firebase_service.dart';

final adjustQuantityprovider =
    ChangeNotifierProvider<DetailscreenNotifier>((ref) {
  return DetailscreenNotifier();
});

class DetailscreenNotifier extends ChangeNotifier {
  final firebaseservice = Firebaseservice();
  int quantity = 1;

  void increseSegmentedValue(int totalquantity, int soldquantity) {
    int remainingquantity = totalquantity - soldquantity;
    if (quantity < remainingquantity) {
      quantity++;
    } else if (quantity >= remainingquantity && remainingquantity < 10) {
      quantity = remainingquantity;

      Fluttertoast.showToast(
          msg: 'Value can be increased up to $remainingquantity',
          backgroundColor: Colors.red);
    } else if (quantity >= remainingquantity) {
      Fluttertoast.showToast(
          msg: 'Value must be less than $remainingquantity', backgroundColor: Colors.red);
    }
    notifyListeners();
  }

  void decreseSegmentedValue() {
    if (quantity > 1) {
      quantity--;
    }
    notifyListeners();
  }

  void resetquentity() {
    quantity = 1;
  }

  int updateSoldQuantity(String productid, int soldqunatity) {
    int soldquant = soldqunatity + quantity;
    firebaseservice.updateSoldProductQuantity(productid, soldquant);
     firebaseservice.updateSoldProductQuantityYearCollection(productid, soldquant);
    notifyListeners();
    return soldquant;
  }

}
