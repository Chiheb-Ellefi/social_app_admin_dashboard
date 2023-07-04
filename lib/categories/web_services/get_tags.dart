import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';

class GetTags {
  Future<DocumentSnapshot> getTagsDoc() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(tagsCollection)
        .doc('myTags')
        .get();
    return snapshot;
  }

  updateTag({newTags}) async {
    await FirebaseFirestore.instance
        .collection(tagsCollection)
        .doc('myTags')
        .update({'tags': newTags});
  }
}
