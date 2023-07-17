import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';
import 'package:dashboard/data/models/ban_model.dart';
import 'package:dashboard/data/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  deleteUser(String uid, String imageURL) async {
    FirebaseFirestore.instance.collection(usersCollection).doc(uid).delete();

    // Delete documents from the 'topicsCollection' where 'authorUid' matches 'uid'
    FirebaseFirestore.instance
        .collection(topicsCollection)
        .where('authorUid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    // Delete documents from the 'reportsCollection' where 'reported' matches 'uid'
    FirebaseFirestore.instance
        .collection(reportsCollection)
        .where('reported', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    // Delete documents from the 'notifCollection' where 'notified' matches 'uid'
    FirebaseFirestore.instance
        .collection(notifCollection)
        .where('notified', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    // Delete documents from the 'tagsCollection' where 'uid' matches 'uid'
    FirebaseFirestore.instance
        .collection(tagsCollection)
        .where('uid', isEqualTo: uid)
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference.delete();
            }));

    // Get the image URL from Firestore Storage based on 'uid' and delete the file
    FirebaseStorage.instance.refFromURL(imageURL).delete().then((_) {
      print('Image file deleted successfully.');
    }).catchError((error) {
      print('Failed to delete the image file: $error');
    });
    await deleteFolder(uid);
  }

  Future<void> deleteFolder(String uid) async {
    final ListResult listResult =
        await FirebaseStorage.instance.ref('files/topics_pic/$uid').listAll();

    final List<Future<void>> deleteFutures = [];

    for (final Reference ref in listResult.items) {
      deleteFutures.add(ref.delete());
    }

    for (final Reference ref in listResult.prefixes) {
      deleteFutures.add(deleteFolder(ref.fullPath));
    }

    await Future.wait(deleteFutures);

    // Delete the empty folder itself
    await FirebaseStorage.instance.ref('files/topics_pic/$uid').delete();
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
