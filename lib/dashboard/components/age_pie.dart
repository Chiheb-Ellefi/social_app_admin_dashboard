import 'package:dashboard/dashboard/webservices/get_info.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyPie extends StatefulWidget {
  const MyPie({super.key});

  @override
  State<MyPie> createState() => _MyPieState();
}

class _MyPieState extends State<MyPie> {
  GetInfo info = GetInfo();
  Map<String, int>? data = {};
  List<_PieData> dataList = [];
  getUsersAge() async {
    data = await info.getUsersAge();
    if (mounted) {
      setState(() {
        dataList = data!.entries.map((e) => _PieData(e.key, e.value)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUsersAge();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: SfCircularChart(
          title: ChartTitle(
              text: 'Age range',
              textStyle: TextStyle(
                  color: Colors.grey.shade100.withOpacity(.7), fontSize: 25)),
          borderWidth: 1,
          legend: Legend(
              isVisible: true,
              textStyle: TextStyle(color: Colors.grey.shade100)),
          series: <PieSeries<_PieData, String>>[
            PieSeries<_PieData, String>(
                explode: true,
                explodeIndex: 0,
                dataSource: dataList,
                xValueMapper: (_PieData data, _) => data.xData,
                yValueMapper: (_PieData data, _) => data.yData,
                dataLabelSettings: const DataLabelSettings(isVisible: false)),
          ]),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
