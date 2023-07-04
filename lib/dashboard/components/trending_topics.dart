import 'package:dashboard/dashboard/components/topic.dart';
import 'package:dashboard/dashboard/webservices/get_info.dart';
import 'package:dashboard/data/models/topic_model.dart';
import 'package:flutter/material.dart';

class TrendingTopics extends StatefulWidget {
  const TrendingTopics({Key? key}) : super(key: key);

  @override
  State<TrendingTopics> createState() => _TrendingTopicsState();
}

class _TrendingTopicsState extends State<TrendingTopics> {
  GetInfo info = GetInfo();
  List<TopicModel>? myData;
  getTopics() async {
    myData = await info.getTopTopics(context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.shade100.withOpacity(0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trending topics',
              style: TextStyle(
                color: Colors.grey.shade100.withOpacity(.7),
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 180,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey.shade200.withOpacity(.5),
                ),
                itemCount: myData?.length ?? 0,
                itemBuilder: (context, index) {
                  TopicModel topic = myData![index];
                  return Topic(
                    rating: topic.rate!,
                    title: topic.title!,
                    username: topic.author!,
                    date: topic.date!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
