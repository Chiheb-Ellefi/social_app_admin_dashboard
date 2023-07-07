import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/components/popup_menu_button.dart';
import 'package:dashboard/data/models/report_model.dart';
import 'package:dashboard/data/models/topic_model.dart';
import 'package:dashboard/reports/components/delete_dialog.dart';
import 'package:dashboard/reports/components/report_tile.dart';
import 'package:dashboard/reports/components/topic_alert.dart';
import 'package:dashboard/reports/web_services/get_reports.dart';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  GetReports getReports = GetReports();
  late Stream<QuerySnapshot<ReportModel>> stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stream = getReports.getQuery().snapshots();
  }

  deleteDialog({uid}) {
    showDialog(
        context: context,
        builder: (context) => DeleteDialog(
              delete: () {
                getReports.deleteReports(uid);
                getReports.deleteTopic(uid);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Reports',
          style: TextStyle(fontSize: 25, color: Colors.grey.shade100),
        ),
        actions: const [
          MyPopUpMenuButton(),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final documents = snapshot.data?.docs ?? [];
                  return Center(
                    child: SizedBox(
                        width: (MediaQuery.of(context).size.width / 10) * 8,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
                          ),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final report = documents[index].data();
                            final List? reasons = report.reasons;
                            final uid = report.reported;
                            return Expanded(
                              child: FutureBuilder<TopicModel?>(
                                  future: getReports.getInfo(uid: uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      final topic = snapshot.data;
                                      return ReportTile(
                                          title: topic!.title,
                                          author: topic.author,
                                          delete: () {
                                            deleteDialog(uid: uid);
                                          },
                                          read: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    TopicAlert(
                                                      title: topic.title,
                                                      description:
                                                          topic.description,
                                                      author: topic.author,
                                                      reasons: reasons,
                                                      delete: () {
                                                        deleteDialog(uid: uid);
                                                      },
                                                    ));
                                          });
                                    }
                                  }),
                            );
                          },
                        )),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
