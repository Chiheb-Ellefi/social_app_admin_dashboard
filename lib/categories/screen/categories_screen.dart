import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/categories/components/delete_tag_dialog.dart';
import 'package:dashboard/categories/components/edit_tag_dialog.dart';
import 'package:dashboard/categories/components/tags_list_tile.dart';
import 'package:dashboard/categories/web_services/get_tags.dart';
import 'package:dashboard/components/popup_menu_button.dart';
import 'package:dashboard/dashboard/webservices/get_info.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  GetTags getTags = GetTags();
  GetInfo getInfo = GetInfo();
  Map myData = {};
  List<dynamic> newTags = [];
  List<dynamic> myTags = [];
  Map<String, int>? topicsPerCategory;

  late DocumentSnapshot snapshot;

  Future<void> getSnapshot() async {
    snapshot = await getTags.getTagsDoc();
    myData = snapshot.data() as Map;
    myTags = myData['tags'];
    topicsPerCategory = await getInfo.getCategoryTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: FutureBuilder(
              future: getSnapshot(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while fetching the tags
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error loading tags');
                } else {
                  return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
                          ),
                      itemCount: myTags.length,
                      itemBuilder: (context, index) {
                        int numberOfTopics = topicsPerCategory![myTags[index]]!;
                        return TagsListTile(
                            delete: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => DeleteTagDialog(
                                        myTags: myTags,
                                        index: index,
                                        setState: () {
                                          setState(() {});
                                        },
                                      ));
                            },
                            edit: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => EditTag(
                                        myTags: myTags,
                                        index: index,
                                        setState: () {
                                          setState(() {});
                                        },
                                      ));
                            },
                            num: numberOfTopics,
                            text: myTags[index]);
                      });
                }
              }),
        ));
  }
}
