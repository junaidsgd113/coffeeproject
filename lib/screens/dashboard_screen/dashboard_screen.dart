import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeproject/widgets/custom_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:coffeeproject/screens/dashboard_screen/pagination_table.dart';
import 'package:month_year_picker/month_year_picker.dart';
import '../../core/models/product/product.dart';
import '../../core/riverpod/dashboard_screen_providers/dashboardscreenstate_providers.dart';
import '../../core/riverpod/dashboard_screen_providers/monthlyfinance_provider.dart';
import '../../core/riverpod/dashboard_screen_providers/paginationtable_provider.dart';
import '../../core/riverpod/dashboard_screen_providers/piegraph_provider.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  Map<String, double> data = {
    "No Sold Product": 0,
  };

  bool _showDatePicker = false;

  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch);

  String formattedMonth = DateFormat.yMMMM().format(
      DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch));
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        ref.read(pagiNationTableProvider.notifier).fetchsoldproducts(dateTime);
        ref
            .read(monthlyFinanceProvider.notifier)
            .filterSoldProductsYearly(dateTime);
        ref.read(pieGraphProvider.notifier).filterPieGraphMonthly(dateTime);
        ref.read(selectMMYYStateProvider.notifier).state = dateTime;
        ref.read(selectYearStateProvider.notifier).state = dateTime;
        ref.read(selectMonthYearStateProvider.notifier).state = dateTime;
        ref.read(selectPickerStateProvider.notifier).state = 'Current Month';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fianceDetails = ref.watch(financeDetailsStateProvider);
    final selectYear = ref.watch(selectYearStateProvider);
    final selectMMYY = ref.watch(selectMMYYStateProvider);
    final pieGraph = ref.watch(pieGraphStateProvider) ?? {};
    final dataMap = pieGraph.isNotEmpty ? pieGraph : data;
    final selectDateRange = ref.watch(selectDateRangeStateProvider);
    final selectMonthYear = ref.watch(selectMonthYearStateProvider);
    final selectPicker = ref.watch(selectPickerStateProvider);
    List<Product> fetchMMproducts = ref.watch(fectchProductsStateprovider);
    List<Product> fetchproductsdateRange = ref.watch(fectchRangeProductsStateprovider);
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xffF4F6F8),
        toolbarHeight: 50,
        elevation: 0,
        title: const Center(
            child: Text(
          'Dashboard',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              color: Colors.black),
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).size.width>400?const EdgeInsets.symmetric(horizontal: 24):const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 480,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1, blurStyle: BlurStyle.normal)
                          ]),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                      'Sold Products',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30,bottom: 20),
                                    child: Container(
                                      height: 50,
                                      width: 170,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 1,
                                                blurStyle: BlurStyle.normal)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4),
                                            child: Text(
                                              " ${selectMMYY != null ? DateFormat('MMMM, yyyy').format(selectMMYY) : "No Month selected"}",
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                DateTime? newDate =
                                                    await showMonthYearPicker(
                                                        context: context,
                                                        initialDate: selectMMYY ??
                                                            DateTime.now(),
                                                        firstDate: DateTime(2022),
                                                        lastDate: DateTime(2050));
                                                if (newDate != null) {
                                                  ref
                                                      .read(selectMMYYStateProvider
                                                          .notifier)
                                                      .state = newDate;
                                                  ref
                                                      .read(pieGraphProvider.notifier)
                                                      .filterPieGraphMonthly(newDate);
                                                }
                                              },
                                              child:  const Icon(Icons.date_range_sharp,size:22,color: Colors.black, )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                           const Padding(
                             padding: EdgeInsets.symmetric(horizontal: 24),
                             child: Divider(
                              height: 30,
                             
                              color: Colors.grey,
                              thickness: 0.5,
                                                     ),
                           ),
                            SizedBox(
                              height: 300,
                              child: Center(
                                child: PieChart(
                                  dataMap: dataMap,
                                  animationDuration:
                                      const Duration(milliseconds: 800),
                                  chartLegendSpacing: 32,
                                  legendOptions: const LegendOptions(
                                    showLegendsInRow: false,
                                    showLegends: true,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(fontSize: 16),
                                  ),
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: false,
                                    decimalPlaces: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: 780,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1, blurStyle: BlurStyle.normal)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        verticalDirection: VerticalDirection.down,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          PaginatedDataTable(
                            source: MyData(
                                products: _showDatePicker
                                    ? fetchproductsdateRange
                                    : fetchMMproducts),
                            header: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Summary',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  DropdownButton<String>(
                                    value: selectPicker,
                                    items: <String>[
                                      'Current Month',
                                      'Range Picker',
                                      'Month Pcker',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: const TextStyle(
                                                  fontSize: 12)));
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        ref
                                            .read(selectPickerStateProvider
                                                .notifier)
                                            .state = newValue;
                                        _showDatePicker =
                                            (newValue == 'Range Picker');
                                      }
                                    },
                                  ),
                                  _showDatePicker
                                      ? Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                    " ${selectDateRange != null ? "${DateFormat('MMMM,dd yyyy').format(selectDateRange.start)} - ${DateFormat('MMMM,dd yyyy').format(selectDateRange.end)}" : "No Range selected"}",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                TextButton(
                                                    onPressed: () async {
                                                      DateTimeRange? newDate =
                                                          await showDateRangePicker(
                                                              context: context,
                                                              initialDateRange:
                                                                  selectDateRange,
                                                              firstDate:
                                                                  DateTime(
                                                                      2022),
                                                              lastDate:
                                                                  DateTime(
                                                                      2100));
                                                      if (newDate != null) {
                                                        ref
                                                            .read(
                                                                selectDateRangeStateProvider
                                                                    .notifier)
                                                            .state = newDate;

                                                        ref
                                                            .read(
                                                                pagiNationTableProvider
                                                                    .notifier)
                                                            .filterPaginationTableRange(
                                                                newDate.start,
                                                                newDate.end);
                                                      }
                                                    },
                                                    child: const Icon(Icons.date_range_sharp,size:20,color: Colors.black, )),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  " ${selectMonthYear != null ? DateFormat('MMMM, yyyy').format(selectMonthYear) : "No Month selected"}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                TextButton(
                                                    onPressed: () async {
                                                      DateTime? newDate =
                                                          await showMonthYearPicker(
                                                              context: context,
                                                              initialDate:
                                                                  selectMonthYear ??
                                                                      DateTime
                                                                          .now(),
                                                              firstDate:
                                                                  DateTime(
                                                                      2022),
                                                              lastDate:
                                                                  DateTime(
                                                                      3000));
                                                      if (newDate != null) {
                                                        ref
                                                            .read(
                                                                selectMonthYearStateProvider
                                                                    .notifier)
                                                            .state = newDate;

                                                        ref
                                                            .read(
                                                                pagiNationTableProvider
                                                                    .notifier)
                                                            .filterPaginationTableMonthly(
                                                                newDate);
                                                      }
                                                    },
                                                    child: const Icon(Icons.date_range_sharp,size:20,color: Colors.black, )),
                                              ],
                                            ),
                                          ],
                                        ),
                                ]),
                            columns: const [
                              DataColumn(label: Text('Category')),
                              DataColumn(label: Text('Title')),
                              DataColumn(label: Text("Actual.price")),
                              DataColumn(label: Text("Sold.price")),
                              DataColumn(label: Text("Sold.quantity")),
                              DataColumn(label: Text("Total.quantity")),
                            ],
                            columnSpacing: 60,
                            horizontalMargin: 10,
                            rowsPerPage: 6,
                            showCheckboxColumn: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    height: 440,
                    width: 1200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(blurRadius: 1, blurStyle: BlurStyle.normal)
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Finance Analytic',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24)),
                                    Container(
                                      height: 60,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 1,
                                                blurStyle: BlurStyle.normal)
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            " ${selectYear != null ? DateFormat(' yyyy').format(selectYear) : "No Year selected"}",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                DateTime? newDate =
                                                    await showMonthYearPicker(
                                                        context: context,
                                                        initialDate:
                                                            selectYear ??
                                                                DateTime.now(),
                                                        firstDate:
                                                            DateTime(2022),
                                                        lastDate:
                                                            DateTime(2050));
                                                if (newDate != null) {
                                                  ref
                                                      .read(
                                                          selectYearStateProvider
                                                              .notifier)
                                                      .state = newDate;
                                                  ref
                                                      .read(
                                                          monthlyFinanceProvider
                                                              .notifier)
                                                      .filterSoldProductsYearly(
                                                          newDate);
                                                }
                                              },
                                              child:
                                                  const Icon(Icons.date_range_sharp,size:20,color: Colors.black, )),
                                        ],
                                      ),
                                    ),
                                  ])),
                          const Padding(
                             padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(
                              height: 30,
                              color: Colors.grey,
                              thickness: 1,
                            ),
                          ),
                          SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                      text: 'Month',
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600))),
                              primaryYAxis: NumericAxis(
                                  title: AxisTitle(
                                      text: 'Amount in Rs.',
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600))),
                              title: ChartTitle(
                                  text: 'Monthly Finance Details',
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              legend: const Legend(
                                isVisible: true,
                              ),
                              series: <ChartSeries>[
                                ColumnSeries<ChartData, String>(
                                  dataSource: fianceDetails,
                                  xValueMapper: (ChartData data, _) =>
                                      data.timestamp.customFormattedDate(),
                                  yValueMapper: (ChartData data, _) =>
                                      data.expense.toDouble(),
                                  borderRadius: BorderRadius.circular(10),
                                  width: 0.15,
                                  spacing: 0.2,
                                  color: Colors.red,
                                  name: 'Expense',
                                  enableTooltip: true,
                                ),
                                ColumnSeries<ChartData, String>(
                                    dataSource: fianceDetails,
                                    xValueMapper: (ChartData data, _) =>
                                        data.timestamp.customFormattedDate(),
                                    yValueMapper: (ChartData data, _) =>
                                        data.income.toDouble(),
                                    borderRadius: BorderRadius.circular(10),
                                    width: 0.15,
                                    spacing: 0.2,
                                    color: Colors.green,
                                    name: 'income')
                              ])
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.expense, this.income, this.timestamp);
  double expense;
  double income;
  Timestamp timestamp;
}
