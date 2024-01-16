import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeasureChartLoading extends StatelessWidget {
  const MeasureChartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _Loading();
      },
    );
  }
}

class _Loading extends StatefulWidget {
  const _Loading();

  @override
  State<_Loading> createState() => _LoadingState();
}

class _LoadingState extends State<_Loading> {
  late List<_ChartData> chartData;
  late int index;

  @override
  void initState() {
    index = 0;
    chartData = [];

    _updateChartData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateChartData() {
    chartData = <_ChartData>[];

    for (int i = 1; i <= 5; i++) {
      final int addedDays = i * 15;
      final date = DateTime.now().add(Duration(days: addedDays));
      final randomValue = _getRandomInt(10, 95);

      chartData.add(_ChartData(date, randomValue));
    }
  }

  int _getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: context.appColors.loadingBackground,
        margin: EdgeInsets.all(0),
        elevation: 0,
        child: Shimmer.fromColors(
          child: SfCartesianChart(
            enableAxisAnimation: true,
            plotAreaBorderWidth: 0,
            title: ChartTitle(
              text: '----------',
              textStyle: TextStyle(color: context.appColors.textContrast),
            ),
            primaryXAxis: CategoryAxis(
              labelStyle: TextStyle(),
              majorGridLines: MajorGridLines(
                dashArray: [4, 6],
              ),
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '----',
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              labelStyle: TextStyle(),
            ),
            series: [
              LineSeries<_ChartData, String>(
                dataSource: chartData,
                xValueMapper: (_ChartData sales, _) => sales.x.format('d MMM'),
                yValueMapper: (_ChartData sales, _) => sales.y,
                name: 'Peso',
                markerSettings: const MarkerSettings(isVisible: true),
                color: context.appColors.textContrast,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  color: context.appColors.primary,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  opacity: .5,
                  useSeriesColor: true,
                ),
              ),
            ],
          ),
          baseColor: context.appColors.loadingBase!,
          highlightColor: context.appColors.loadingHighlight!,
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final DateTime x;
  final int y;
}
