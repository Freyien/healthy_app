import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthy_app/core/domain/enums/fetching_status.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/di/di_business.dart';
import 'package:healthy_app/features/client/measures_chart/ui/bloc/measure_bloc.dart';
import 'package:healthy_app/features/client/measures_chart/ui/widgets/measure_chart_loading.dart';
import 'package:healthy_app/features/client/measures_chart/ui/widgets/measure_line_chart.dart';

class MeasuresChartPage extends StatelessWidget {
  const MeasuresChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<MeasureBloc>()..add(GetMeasureConsultationEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Medidas'),
        ),
        body: Builder(builder: (context) {
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              context.read<MeasureBloc>().add(GetMeasureConsultationEvent());
            },
            child: BlocBuilder<MeasureBloc, MeasureState>(
              buildWhen: (p, c) => p.fetchingStatus != c.fetchingStatus,
              builder: (context, state) {
                if (state.fetchingStatus == FetchingStatus.initial)
                  return MeasureChartLoading();

                if (state.fetchingStatus == FetchingStatus.loading)
                  return MeasureChartLoading();

                if (state.fetchingStatus == FetchingStatus.failure)
                  return ErrorFullScreen(onRetry: () {
                    context
                        .read<MeasureBloc>()
                        .add(GetMeasureConsultationEvent());
                  });

                if (state.chartDataList.isEmpty)
                  return MessageFullScreen(
                    widthPercent: .4,
                    animationName: 'empty',
                    title: 'No hay medidas disponibles',
                    subtitle:
                        'No tienes medidas registradas, acércate con tu nutriólogo/a',
                  );

                // ListView.custom(childrenDelegate: childrenDelegate);

                return ListView.builder(
                  addAutomaticKeepAlives: true,
                  padding: EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.chartDataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final chartData = state.chartDataList[index];

                    return Card(
                      margin: EdgeInsets.only(bottom: 24),
                      child: MeasureLineChart(chartData: chartData),
                    );
                  },
                );

                return SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // SfCartesianChart(
                      //   plotAreaBorderWidth: 0,
                      //   // title: ChartTitle(
                      //   //   text: 'Peso',
                      //   //   textStyle: TextStyle(color: context.appColors.textContrast),
                      //   // ),
                      //   legend: Legend(
                      //     isVisible: true,
                      //     overflowMode: LegendItemOverflowMode.wrap,
                      //     textStyle: TextStyle(
                      //       color: context.appColors.textContrast,
                      //     ),
                      //   ),
                      //   primaryXAxis: CategoryAxis(
                      //     labelStyle: TextStyle(color: context.appColors.textContrast),
                      //     axisLine: AxisLine(width: 0),
                      //     majorTickLines: MajorTickLines(width: 0),
                      //     majorGridLines: MajorGridLines(width: 0),
                      //   ),
                      //   primaryYAxis: const NumericAxis(
                      //     labelFormat: '{value} kgs',
                      //     minimum: 57,
                      //     maximum: 78,
                      //     interval: 3,
                      //     majorTickLines: MajorTickLines(size: 0),
                      //     axisLine: AxisLine(width: 0),
                      //     labelPosition: ChartDataLabelPosition.outside,
                      //   ),
                      //   series: <ColumnSeries<_ChartData, String>>[
                      //     ColumnSeries<_ChartData, String>(
                      //       width: 0.8,
                      //       dataLabelSettings: DataLabelSettings(
                      //         isVisible: true,
                      //         labelAlignment: ChartDataLabelAlignment.top,
                      //         builder: (data, point, series, pointIndex, seriesIndex) {
                      //           return Column(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Text(
                      //                 '${data.y}',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   fontSize: 13,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 'kgs',
                      //                 textAlign: TextAlign.center,
                      //                 style: TextStyle(
                      //                   fontSize: 11,
                      //                   letterSpacing: 1.2,
                      //                   color: Colors.white,
                      //                 ),
                      //               ),
                      //             ],
                      //           );
                      //         },
                      //       ),
                      //       dataSource: <_ChartData>[
                      //         _ChartData(DateTime.now(), 62, 28),
                      //         _ChartData(DateTime.now().add(Duration(days: 15)), 68, 44),
                      //         _ChartData(DateTime.now().add(Duration(days: 30)), 69, 44),
                      //         _ChartData(DateTime.now().add(Duration(days: 60)), 72, 44),
                      //         _ChartData(DateTime.now().add(Duration(days: 75)), 75, 44),
                      //       ],
                      //       borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                      //       xValueMapper: (_ChartData sales, _) => sales.x.format('MMMd'),
                      //       yValueMapper: (_ChartData sales, _) => sales.y,
                      //       color: context.appColors.primary!.withOpacity(.7),
                      //       name: 'Peso',
                      //     ),
                      //   ],
                      //   tooltipBehavior: TooltipBehavior(
                      //     enable: true,
                      //   ),
                      // )
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
