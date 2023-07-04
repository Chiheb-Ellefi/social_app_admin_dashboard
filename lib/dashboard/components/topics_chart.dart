import 'package:dashboard/dashboard/webservices/get_info.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopicsChart extends StatefulWidget {
  const TopicsChart({Key? key});

  @override
  State<TopicsChart> createState() => _TopicsChartState();
}

class _TopicsChartState extends State<TopicsChart> {
  GetInfo info = GetInfo();
  Future<Map<String, int>>? numberOfTopicsFuture;

  Future<void> getNumberOfTopicsPerDay() async {
    numberOfTopicsFuture = info.getNumberOfTopicsPerDay();
  }

  @override
  void initState() {
    super.initState();
    getNumberOfTopicsPerDay();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: numberOfTopicsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<String, int> numberOfTopics = snapshot.data as Map<String, int>;

          // Access the resolved value
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries>[
              SplineSeries<MapEntry<String, int>, String>(
                dataSource: numberOfTopics.entries.toList(),
                xValueMapper: (entry, _) => entry.key,
                yValueMapper: (entry, _) => entry.value,
                color: const Color.fromRGBO(0, 168, 181, 1), // Set spline color
                markerSettings: const MarkerSettings(
                  // Customize marker appearance
                  isVisible: true,
                  color: Color.fromRGBO(0, 168, 181, 1),
                  borderWidth: 2,
                  width: 6,
                  height: 6,
                ),
                width: 2, // Adjust spline line width
              ),
            ],
            primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 0), // Hide y-axis line
              majorTickLines:
                  const MajorTickLines(size: 0), // Hide y-axis tick lines
            ),
            plotAreaBorderWidth: 0, // Hide chart plot area border
            enableAxisAnimation: true, // Enable axis animation
          );
        }
      },
    );
  }
}
