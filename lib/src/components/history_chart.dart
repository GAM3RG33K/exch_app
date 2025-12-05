import 'package:exch_app/src/constants.dart';
import 'package:exch_app/src/models/api/rate_history.dart';
import 'package:exch_app/src/utils/application/context_helper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryChart extends StatelessWidget {
  final RateHistory historyData;
  final bool isLoading;

  const HistoryChart({
    super.key,
    required this.historyData,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (historyData.history.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No history data available")),
      );
    }

    final sortedKeys = historyData.history;
    final spots = <FlSpot>[];

    for (int i = 0; i < sortedKeys.length; i++) {
      final entry = sortedKeys[i];
      final rate = entry.rate;
      spots.add(FlSpot(i.toDouble(), rate.toDouble()));
    }

    final minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.1;

    // Calculate trend based on the last two data points to match the "current trend"
    // and ensure consistency with the last tooltip.
    final isPositiveTrend =
        spots.length < 2 ? true : spots.last.y >= spots[spots.length - 2].y;

    final mainColor = isPositiveTrend ? AppColors.green : AppColors.red;

    return Container(
      height: context.uHeight * 35,
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: (maxY - minY) / 4,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withValues(alpha: 0.2),
                strokeWidth: 1,
                dashArray: [5, 5],
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: (sortedKeys.length / 4).toDouble(),
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedKeys.length) {
                    final date = sortedKeys[index].date;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat('MMM d').format(date),
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: (maxY - minY) / 4,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minY: minY - padding,
          maxY: maxY + padding,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) {
                final index = touchedSpot.spotIndex;
                if (index == 0) return mainColor;
                final current = spots[index].y;
                final previous = spots[index - 1].y;
                return current >= previous ? AppColors.green : AppColors.red;
              },
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.spotIndex;
                  final date = sortedKeys[index].date;
                  return LineTooltipItem(
                    '${DateFormat('MMM d, yyyy').format(date)}\n',
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: spot.y.toStringAsFixed(4),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: mainColor,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    mainColor.withValues(alpha: 0.3),
                    mainColor.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
