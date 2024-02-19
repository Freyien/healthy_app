import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/core/extensions/datetime.dart';
import 'package:healthy_app/core/ui/extensions/buildcontext.dart';
import 'package:healthy_app/core/ui/widgets/core_widgets.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_chart_data_entity.dart';
import 'package:healthy_app/features/client/measures_chart/domain/entities/measure_chart_element_entity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MeasureLineChart extends StatefulWidget {
  const MeasureLineChart({super.key, required this.chartData});

  final MeasureChartDataEntity chartData;

  @override
  State<MeasureLineChart> createState() => _MeasureLineChartState();
}

class _MeasureLineChartState extends State<MeasureLineChart>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: Legend(
          itemPadding: 0,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          toggleSeriesVisibility: false,
          textStyle: TextStyle(
            color: context.appColors.textContrast,
          ),
          legendItemBuilder: (legendText, series, point, seriesIndex) {
            return AppBar(
              forceMaterialTransparency: true,
              // leading: IconButton(
              //   onPressed: () {},
              //   icon: Icon(CupertinoIcons.fullscreen),
              // ),
              leading: IconButton(
                onPressed: null,
                icon: CachedNetworkImage(
                  imageUrl: widget.chartData.imageUrl,
                  width: 28,
                  height: 28,
                  placeholder: (context, url) {
                    return Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: context.appColors.loadingBackground,
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                ),
              ),
              title: Column(
                children: [
                  Text(
                    legendText,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: context.appColors.textContrast,
                    ),
                  ),
                  VerticalSpace.xsmall(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Medida: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              context.appColors.textContrast!.withOpacity(.7),
                        ),
                      ),
                      Text(
                        widget.chartData.measure,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color:
                              context.appColors.textContrast!.withOpacity(.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
              ],
            );
          },
        ),
        onLegendTapped: null,
        primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(
            color: context.appColors.textContrast!.withOpacity(.7),
          ),
          majorGridLines: MajorGridLines(
            dashArray: [4, 6],
          ),
        ),
        primaryYAxis: NumericAxis(
          labelFormat: '{value} ${widget.chartData.measure}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
          labelStyle: TextStyle(
            color: context.appColors.textContrast!.withOpacity(.7),
          ),
          minimum: widget.chartData.minElementValue.toDouble() - 1,
          maximum: widget.chartData.maxElementValue.toDouble() + 1,
        ),
        series: [
          LineSeries<MeasureChartElementEntity, String>(
            dataSource: widget.chartData.elementList,
            xValueMapper: (element, _) => element.date.format('d/MMM'),
            yValueMapper: (element, _) => element.value,
            name: widget.chartData.text,
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
              builder: (data, point, series, pointIndex, seriesIndex) {
                final num value = data.value;

                return Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.appColors.primary!.withOpacity(.9),
                  ),
                  child: Text(
                    '$value ${widget.chartData.measure}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
