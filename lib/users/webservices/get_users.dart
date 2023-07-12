import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';
import 'package:dashboard/data/models/ban_model.dart';
import 'package:dashboard/data/models/user_model.dart';

class GetUsers {
  Query<UserModel> getQuery() {
    late Query<UserModel> queryUser = FirebaseFirestore.instance
        .collection(usersCollection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
          toFirestore: (user, _) => user.toMap(),
        );
    return queryUser;
  }

  Future<int> getReports({uid}) async {
    int number = await FirebaseFirestore.instance
        .collection(reportsCollection)
        .where('reported', isEqualTo: uid)
        .get()
        .then((querySnapshot) => querySnapshot.size);

    return number;
  }

  deleteUser(String uid) {
    FirebaseFirestore.instance.collection(usersCollection).doc(uid).delete();
  }

  banUser({uid, duration}) async {
    BanModel ban = BanModel(banned: uid, duration: duration);
    await FirebaseFirestore.instance
        .collection(banCollection)
        .doc(uid)
        .set(ban.toMap());
  }

  Future<bool> isBanned({uid}) async {
    bool banned = false;
    final snapshot = await FirebaseFirestore.instance
        .collection(banCollection)
        .doc(uid)
        .get();
    banned = snapshot.exists;
    return banned;
  }
}
