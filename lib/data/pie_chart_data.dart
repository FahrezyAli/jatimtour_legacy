import 'package:fl_chart/fl_chart.dart';
import 'package:jatimtour/constants.dart';

class ChartData {
  final paiChartSelectionDatas = [
    PieChartSectionData(
      color: primaryColor,
      value: 65,
      title: 'Pengunjung',
      showTitle: true,
      titlePositionPercentageOffset: 3.3,
      radius: 20,
    ),
    PieChartSectionData(
      color: selectionColor,
      value: 55,
      title: 'Followers',
      titlePositionPercentageOffset: 3,
      showTitle: true,
      radius: 20,
    ),
  ];
}
