import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeproject/core/riverpod/dashboard_screen_providers/dashboardscreenstate_providers.dart';
import 'package:coffeeproject/core/riverpod/dashboard_screen_providers/monthlyfinance_provider.dart';

import 'package:coffeeproject/widgets/custom_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomSfcartsianGraph extends StatelessWidget {
  const CustomSfcartsianGraph({
    super.key,
    required this.selectYear,
    required this.ref,
    required this.fianceDetails,
  });

  final DateTime? selectYear;

  final WidgetRef ref;
  final List<ChartData> fianceDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Finance Analytic',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 24)),
                          Container(
                            height: 60,
                            width: 150,
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
                                Text(
                                  " ${selectYear != null ? DateFormat(' yyyy').format(selectYear!) : "No Year selected"}",
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
                                                  selectYear ?? DateTime.now(),
                                              firstDate: DateTime(2022),
                                              lastDate: DateTime(2050));
                                      if (newDate != null) {
                                        ref
                                            .read(selectYearStateProvider
                                                .notifier)
                                            .state = newDate;
                                        ref
                                            .read(
                                                monthlyFinanceProvider.notifier)
                                            .filterSoldProductsYearly(newDate);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.date_range_sharp,
                                      size: 20,
                                      color: Colors.black,
                                    )),
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
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600))),
                    primaryYAxis: NumericAxis(
                        title: AxisTitle(
                            text: 'Amount in Rs.',
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600))),
                    title: ChartTitle(
                        text: 'Monthly Finance Details',
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w600)),
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
    );
  }
}
class ChartData {
  ChartData(this.expense, this.income, this.timestamp);
  double expense;
  double income;
  Timestamp timestamp;
}