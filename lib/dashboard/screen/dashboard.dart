import 'package:dashboard/components/popup_menu_button.dart';
import 'package:dashboard/dashboard/components/category_topics_chart.dart';
import 'package:dashboard/dashboard/components/detail_tile.dart';
import 'package:dashboard/dashboard/components/age_pie.dart';
import 'package:dashboard/dashboard/components/topics_chart.dart';
import 'package:dashboard/dashboard/components/trending_topics.dart';
import 'package:dashboard/dashboard/webservices/get_info.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> {
  GetInfo info = GetInfo();
  getDetails() async {
    await info.getInfo();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Dashboard',
            style: TextStyle(fontSize: 25, color: Colors.grey.shade100),
          ),
          actions: const [
            MyPopUpMenuButton(),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey.shade100.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DetailTile(
                            icon: Icons.person,
                            number: info.registredCount ?? 0,
                            text: 'Registered users'),
                        DetailTile(
                            icon: Icons.supervised_user_circle,
                            number: info.anonymousCount ?? 0,
                            text: 'Visitors'),
                        DetailTile(
                            icon: Icons.newspaper,
                            number: info.topicsCount ?? 0,
                            text: 'Topics')
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  children: [
                    Expanded(child: TopicsChart()),
                    MyPie(),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  children: [
                    Expanded(child: TrendingTopics()),
                    TopicsPerCategory(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
