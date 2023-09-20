import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Service/firebase_service.dart';
import '../../models/product/product.dart';
import 'dashboardscreenstate_providers.dart';

final pagiNationTableProvider =
    StateNotifierProvider<PagiNationTableNotifier, List<Product>>(
        (ref) => PagiNationTableNotifier(ref));

class PagiNationTableNotifier extends StateNotifier<List<Product>> {
  PagiNationTableNotifier(Ref ref)
      : _ref = ref,
        super([]);
  final Ref _ref;
  final firebaseservice = Firebaseservice();
 
  Future<void> fetchsoldproducts(DateTime dateTime) async {
    state = await firebaseservice.fetchSoldProductFromDB();
    filterPaginationTableMonthly(dateTime);
   
  }

  Future<void> filterPaginationTableRange( DateTime startdate, DateTime enddate, ) async {
    state = await firebaseservice.fetchDataInRangeFromDB( startdate,  enddate,);
    _ref.read(fectchRangeProductsStateprovider.notifier).state = state;
  }

  Future<void> filterPaginationTableMonthly(DateTime selectmonth) async {
    state = await firebaseservice.fetchDataFromDBMM(selectmonth);
    _ref.read(fectchProductsStateprovider.notifier).state = state;
  }

  // void updatedateinTimestampDB(String productId, DateTime newDate) async {
  //   await firebaseservice.updatedateinTimestampC(productId, newDate);
  // }
}
