import 'package:coffeeproject/screens/dashboard_screen/sfcartesian_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Service/firebase_service.dart';
import '../../models/product/product.dart';
import 'dashboardscreenstate_providers.dart';

final monthlyFinanceProvider =
    StateNotifierProvider<MonthlyFinanceNotifier, List<Product>>(
        (ref) => MonthlyFinanceNotifier(ref));

class MonthlyFinanceNotifier extends StateNotifier<List<Product>> {
  MonthlyFinanceNotifier(Ref ref)
      : _ref = ref,
        super([]);
  final firebaseservice = Firebaseservice();

  final Ref _ref;
  void addSoldProducts(Product saleproduct) {
    state = [...state, saleproduct];
    firebaseservice.addSoldProductToDBYearCollection(saleproduct);
  }

  Future<void> filterSoldProductsYearly(DateTime datetime) async {
    state =  await firebaseservice.fetchSoldProductFromYearCollectionDB(datetime);
    monthlyfinancedetailscaculate();
  }

  void updatedDateSoldProducts(String productId, DateTime newDate) async {
    await firebaseservice.updateDateSoldProductsFromYearCollectionDB(
        productId, newDate);
  }

  void monthlyfinancedetailscaculate() {
    List<ChartData> chartList = [];
    final products = state;
    products.sort(
      (a, b) => a.timestamp.compareTo(b.timestamp),
    );
    for (int i = 0; i < products.length; i++) {
      Product product = products[i];
      double productExpense = 0;
      if (product.actualprice != null) {
        productExpense = (product.totalquantity.toDouble()) *
            (product.actualprice!.toDouble());
      }

      debugPrint(productExpense.toString());
      double productIncome = 0;
      if (product.actualprice != null && product.soldprice != null) {
        productIncome =
            (product.soldprice!.toDouble()) - (product.actualprice!.toDouble());
      }

      ChartData charData = ChartData(
        productExpense,
        productIncome,
        product.timestamp,
      );

      chartList.add(charData);
    
    }
    _ref.read(financeDetailsStateProvider.notifier).state = chartList;
  }
}
