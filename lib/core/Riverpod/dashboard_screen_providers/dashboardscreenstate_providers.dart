import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../screens/dashboard_screen/dashboard_screen.dart';
import '../../models/product/product.dart';
 final fectchProductsYearStateprovider = StateProvider<List<Product>>((ref) => []);
final fectchProductsStateprovider = StateProvider<List<Product>>((ref) => []);
final fectchRangeProductsStateprovider = StateProvider<List<Product>>((ref) => []);
final selectDateRangeStateProvider = StateProvider<DateTimeRange?>((ref) => null);
final selectYearStateProvider = StateProvider<DateTime?>((ref) => null);
final selectMonthYearStateProvider = StateProvider<DateTime?>((ref) => null);
final selectPickerStateProvider = StateProvider<String>((ref) => 'Current Month');
final selectMMYYStateProvider = StateProvider<DateTime?>((ref) => null);
final showdatepickerProvider = StateProvider<DateTime?>((ref) => null);
final financeDetailsStateProvider = StateProvider<List<ChartData>>((ref) => []);
final pieGraphStateProvider = StateProvider<Map<String, double>?>((ref) => null);