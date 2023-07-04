import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';
import 'package:dashboard/constants/firebase_constants.dart';
import 'package:dashboard/data/models/user_model.dart';
import 'package:dashboard/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAdminService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection(usersCollection);

  Future<void> registerWithEmailAndPassword({
    required String username,
    required String mail,
    required String password,
    required String phoneNumber,
    required DateTime dob,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);

      UserModel userModel = UserModel(
        uid: result.user!.uid,
        username: username,
        email: result.user!.email ?? "No email",
        phoneNumber: phoneNumber,
        dateOfBirth: dob,
        profilePicture: avatarDefault,
        followers: [],
        following: [],
        topics: [],
        isAdmin: true,
        isAnonymous: false,
      );

      await _users.doc(result.user!.uid).set(userModel.toMap());

      // Display success message or perform other actions

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
