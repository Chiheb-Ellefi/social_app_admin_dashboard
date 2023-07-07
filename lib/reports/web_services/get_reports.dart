import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';
import 'package:dashboard/data/models/report_model.dart';
import 'package:dashboard/data/models/topic_model.dart';

class GetReports {
  Query<ReportModel> getQuery() {
    late Query<ReportModel> queryReport = FirebaseFirestore.instance
        .collection('topicsReport')
        .withConverter<ReportModel>(
          fromFirestore: (snapshot, _) => ReportModel.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap(),
        );
    return queryReport;
  }

  Future<TopicModel?> getInfo({uid}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(topicsCollection)
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      TopicModel topic =
          TopicModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return topic;
    } else {
      // Handle the case when no topic is found with the given UID
      return null;
    }
  }

  Future<void> deleteTopic(uid) async {
    // Get a reference to the Firestore collection
    CollectionReference topics =
        FirebaseFirestore.instance.collection(topicsCollection);

    // Query the collection to find the document with the matching UID
    QuerySnapshot querySnapshot =
        await topics.where('uid', isEqualTo: uid).get();

    // Iterate through the query results and delete the documents
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }

  Future deleteReports(uid) async {
    CollectionReference reports =
        FirebaseFirestore.instance.collection('topicsReport');

    // Query the collection to find the document with the matching UID
    QuerySnapshot querySnapshot =
        await reports.where('reported', isEqualTo: uid).get();

    // Iterate through the query results and delete the documents
    for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
      await docSnapshot.reference.delete();
    }
  }
}
