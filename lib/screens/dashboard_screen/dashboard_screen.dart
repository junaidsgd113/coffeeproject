import 'package:coffeeproject/screens/dashboard_screen/sfcartesian_chart.dart';
import 'package:coffeeproject/screens/dashboard_screen/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
    List<Product> fetchproductsdateRange =
        ref.watch(fectchRangeProductsStateprovider);
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
          padding: MediaQuery.of(context).size.width > 400
              ? const EdgeInsets.symmetric(horizontal: 24)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              const SizedBox(height: 36),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomPieChart(
                        selectMMYY: selectMMYY, ref: ref, dataMap: dataMap),
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
                                                    child: const Icon(
                                                      Icons.date_range_sharp,
                                                      size: 20,
                                                      color: Colors.black,
                                                    )),
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
                                                    child: const Icon(
                                                      Icons.date_range_sharp,
                                                      size: 20,
                                                      color: Colors.black,
                                                    )),
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
              CustomSfcartsianGraph(
                  selectYear: selectYear,
                  ref: ref,
                  fianceDetails: fianceDetails),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}


