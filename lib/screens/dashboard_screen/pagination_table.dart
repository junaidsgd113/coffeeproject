// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import '../../core/models/product/product.dart';
import '../../core/riverpod/adjustquantity_provider.dart';
import '../../core/riverpod/dashboard_screen_providers/paginationtable_provider.dart';
import '../../core/riverpod/homescreen_provider.dart';

class MyData extends DataTableSource {
  final HomeScreenNotifier? homeprovider;
  final PagiNationTableNotifier? paginationprovider;
  final List<Product>? products;
 final int ?filterdate;
  final DetailscreenNotifier? adjustQuantityNotifier;
  MyData({
    this.homeprovider,
    this.paginationprovider,
    this.products,
     this.filterdate,
    this.adjustQuantityNotifier,
  });

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => products?.length ?? 0;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    if (products != null && index < products!.length) {
      if(filterdate!=null){
            final productDate =DateTime.fromMillisecondsSinceEpoch(products![index].timestamp) ;
    final filterDate = DateTime.fromMillisecondsSinceEpoch(filterdate!);
        if (productDate.day != filterDate.day || productDate.month != filterDate.month || productDate.year != filterDate.year){

         return DataRow.byIndex(
          index: index,
          cells: const [
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            // DataCell(Text('')),
          ],
        );
      }}
      return DataRow(cells: [
        DataCell(Text(products![index].category.toString())),
        DataCell(Text(products![index].title.toString())),
        DataCell(Text(products![index].actualprice.toString())),
        DataCell(Text(products![index].soldprice.toString())),
        DataCell(Text(products![index].soldquantity.toString())),
        DataCell(Text(products![index].totalquantity.toString())),
            // DataCell(Text(DateFormat('MMMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(products![index].updatedatdate)))),
      ]);
    } else {
      // Return an empty DataRow in case of null or index out of range
      return const DataRow(cells: [
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
        DataCell(Text('')),
          DataCell(Text('')),
        // DataCell(Text('')),
      ]);
    }
  }
}
