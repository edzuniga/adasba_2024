import 'package:adasba_2024/constants/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MedicionesComponentesChart extends StatefulWidget {
  const MedicionesComponentesChart({super.key});

  @override
  State<MedicionesComponentesChart> createState() =>
      _MedicionesComponentesChartState();
}

class _MedicionesComponentesChartState
    extends State<MedicionesComponentesChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 305,
      child: LineChart(
        //Datos para el gráfico de líneas
        LineChartData(
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => Colors.white,
            ),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                  color: AppColors.azulPrincipal.withOpacity(0.2), width: 4),
              left: BorderSide(
                  color: AppColors.azulPrincipal.withOpacity(0.2), width: 4),
              right: const BorderSide(color: Colors.transparent),
              top: const BorderSide(color: Colors.transparent),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              color: AppColors.rojoPrincipal,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: const [
                FlSpot(1, 1),
                FlSpot(3, 1.5),
                FlSpot(5, 1.4),
                FlSpot(7, 3.4),
                FlSpot(10, 2),
                FlSpot(12, 2.2),
                FlSpot(13, 1.8),
              ],
            ),
            LineChartBarData(
              isCurved: false,
              color: AppColors.amarilloPrincipal,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              spots: const [
                FlSpot(1, 3),
                FlSpot(3, 2.5),
                FlSpot(5, 0.4),
                FlSpot(7, 3.4),
                FlSpot(10, 3),
                FlSpot(12, 4.2),
                FlSpot(13, 1.8),
              ],
            ),
          ],
          minX: 0,
          maxX: 14,
          maxY: 5,
          minY: 0,
        ),
      ),
    );
  }
}
