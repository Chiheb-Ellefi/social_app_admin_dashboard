import 'package:dashboard/dashboard/webservices/get_info.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TopicsPerCategory extends StatefulWidget {
  const TopicsPerCategory({Key? key}) : super(key: key);

  @override
  State<TopicsPerCategory> createState() => _TopicsPerCategoryState();
}

class _TopicsPerCategoryState extends State<TopicsPerCategory> {
  GetInfo info = GetInfo();
  Map<String, int>? topicsPerCategory;
  getTopicsPerCategory() async {
    topicsPerCategory = await info.getCategoryTopics();
    if (mounted) {
      setState(() {
        myDataList = topicsPerCategory?.entries
            .map((entry) => MyData(entry.value, entry.key))
            .toList();
      });
    }
  }

  List<MyData>? myDataList = [];
  @override
  void initState() {
    super.initState();
    getTopicsPerCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 3),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          BarSeries<MyData, String>(
            dataSource: myDataList!,
            xValueMapper: (MyData data, _) => data.category,
            yValueMapper: (MyData data, _) => data.value,
          ),
        ],
      ),
    );
  }
}

class MyData {
  final num value;
  final String category;

  MyData(this.value, this.category);
}
