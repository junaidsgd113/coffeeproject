import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Service/firebase_service.dart';
import '../../models/product/product.dart';
import 'dashboardscreenstate_providers.dart';

final pieGraphProvider = StateNotifierProvider<PieGraphNotifier, List<Product>>(
    (ref) => PieGraphNotifier(ref));

class PieGraphNotifier extends StateNotifier<List<Product>> {
  PieGraphNotifier(Ref ref)
      : _ref = ref,
        super([]);
  final firebaseservice = Firebaseservice();

  final Ref _ref;
    void addSoldProduct(Product saleproduct) {
    state = [...state, saleproduct];
    firebaseservice.addSoldProductToDB(saleproduct);
    
  }
void updateDateSoldProducts(String productId, DateTime newDate) async {
    await firebaseservice.updateDateSoldProductsFromDB(productId, newDate);
  }
  Future<void> filterPieGraphMonthly(DateTime datetime) async {
    state = await firebaseservice.fetchDataFromDBMM(datetime);
    updateDataMap();
  }

  void updateDataMap() {
    Map<String, double> dataMap = {};
    //dataMap.clear(); // Clear existing data
    final products = state;
    for (var product in products) {
      final category = product.category ?? '';
      final soldQuantity = product.soldquantity.toDouble();
      final totalQuantity = product.totalquantity.toDouble();
      double percentage;
      if (soldQuantity == 0) {
        percentage = 0;
      } else if (soldQuantity == totalQuantity) {
        percentage = 1.0; // 100%
      } else {
        percentage = (soldQuantity / totalQuantity);
      }

      if (dataMap.containsKey(category)) {
        dataMap[category] = (dataMap[category] ?? 0) + percentage;
      } else {
        dataMap[category] = percentage;
      }
    }

    _ref.read(pieGraphStateProvider.notifier).state = dataMap;
  }
}
