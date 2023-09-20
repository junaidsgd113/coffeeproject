import 'package:coffeeproject/core/riverpod/dashboard_screen_providers/dashboardscreenstate_providers.dart';
import 'package:coffeeproject/core/riverpod/dashboard_screen_providers/piegraph_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:pie_chart/pie_chart.dart';
class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    super.key,
    required this.selectMMYY,
    required this.ref,
    
    required this.dataMap,
  });

  final DateTime? selectMMYY;
  final WidgetRef ref;
  
  final Map<String, double> dataMap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sold Products',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 20),
                    child: Container(
                      height: 50,
                      width: 170,
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
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 4),
                            child: Text(
                              " ${selectMMYY != null ? DateFormat('MMMM, yyyy').format(selectMMYY!) : "No Month selected"}",
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
                                        initialDate:
                                            selectMMYY ??
                                                DateTime.now(),
                                        firstDate:
                                            DateTime(2022),
                                        lastDate:
                                            DateTime(2050));
                                if (newDate != null) {
                                  ref
                                      .read(
                                          selectMMYYStateProvider
                                              .notifier)
                                      .state = newDate;
                                  ref
                                      .read(pieGraphProvider
                                          .notifier)
                                      .filterPieGraphMonthly(
                                          newDate);
                                }
                              },
                              child: const Icon(
                                Icons.date_range_sharp,
                                size: 22,
                                color: Colors.black,
                              )),
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
    );
  }
}