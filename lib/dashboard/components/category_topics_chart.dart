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
  List<MyData>? myDataList = [];

  getTopicsPerCategory() async {
    topicsPerCategory = await info.getCategoryTopics();

    if (mounted) {
      setState(() {
        // Sort the categories based on the topic count in descending order
        final sortedEntries = topicsPerCategory?.entries.toList();
        sortedEntries?.sort((a, b) => b.value.compareTo(a.value));

        // Select the top 5 categories
        final topCategories = sortedEntries?.take(5).toList();

        // Calculate the sum of the remaining categories
        int sumOfOthers = 0;
        if (sortedEntries != null && sortedEntries.length > 5) {
          for (var i = 5; i < sortedEntries.length; i++) {
            sumOfOthers += sortedEntries[i].value;
          }
        }

        // Create data points for the top 5 categories
        myDataList = topCategories
            ?.map((entry) => MyData(entry.value, entry.key))
            .toList();

        // Add the "Others" category
        if (sumOfOthers > 0) {
          myDataList?.add(MyData(sumOfOthers, 'Others'));
        }
      });
    }
  }

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
