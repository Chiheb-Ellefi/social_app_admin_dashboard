import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';

class GetTermsOfUse {
  Future<String> getTerms() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(termsCollection)
        .doc('termsOfUse')
        .get();
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    return data['terms'];
  }

  Future<void> updateTerms({terms}) async {
    await FirebaseFirestore.instance
        .collection(termsCollection)
        .doc('termsOfUse')
        .update({'terms': terms});
  }
}
