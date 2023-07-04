import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';
import 'package:dashboard/data/models/user_model.dart';

class GetAdmin {
  Future<bool> isAdmin(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        .where('email', isEqualTo: email)
        .get();

    bool isAdmin = false;
    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> data = snapshot.docs[0].data();
      UserModel user = UserModel.fromMap(data);
      isAdmin = user.isAdmin!;
    }

    return isAdmin;
  }

  Future<UserModel> getAdminProfile({String? uid}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(usersCollection)
        .doc(uid)
        .get();
    Map<String, dynamic> data = snapshot.data()!;
    UserModel user = UserModel.fromMap(data);

    return user;
  }
}
