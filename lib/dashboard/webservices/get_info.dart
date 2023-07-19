import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/constants/constants.dart';
import 'package:dashboard/data/models/topic_model.dart';
import 'package:flutter/material.dart';

class GetInfo {
  int? registredCount;
  int? anonymousCount;
  int? topicsCount;
  Future<void> getInfo() async {
    final registredSnapshot = await FirebaseFirestore.instance
        .collection(usersCollection)
        .where('isAnonymous', isEqualTo: false)
        .get();
    registredCount = registredSnapshot.docs.length;

    final anonymousSnapshot = await FirebaseFirestore.instance
        .collection('anonymousUsers')
        .doc('users')
        .get();
    Map data = anonymousSnapshot.data() as Map;
    List users = data['anonUsers'];
    anonymousCount = users.length;

    final topicsSnapshot =
        await FirebaseFirestore.instance.collection(topicsCollection).get();
    topicsCount = topicsSnapshot.docs.length;
  }

  Future<Map<String, int>> getNumberOfTopicsPerDay() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(topicsCollection);
    QuerySnapshot querySnapshot = await collectionRef.get();
    Map<String, int> documentsPerDay = {};
    for (var doc in querySnapshot.docs) {
      int timestamp = doc.get('date');
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      String date = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
      if (documentsPerDay.containsKey(date)) {
        documentsPerDay[date] = documentsPerDay[date]! + 1;
      } else {
        documentsPerDay[date] = 1;
      }
    }
    return documentsPerDay;
  }

  Future<List<TopicModel>> getTopTopics(BuildContext context) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(topicsCollection)
          .orderBy('rate', descending: true)
          .limit(5)
          .get();
      List<TopicModel> topicsList = [];
      for (var element in snapshot.docs) {
        topicsList.add(TopicModel.fromMap(element.data()));
      }
      return topicsList;
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return []; // Return an empty list or handle the error appropriately
    }
  }

  Future<Map<String, int>> getCategoryTopics() async {
    try {
      final tagsRef =
          FirebaseFirestore.instance.collection(tagsCollection).doc('myTags');
      final querySnapshot = await tagsRef.get();
      final data = querySnapshot.data();

      if (data != null) {
        final tagsList = List<String>.from(data['tags'] ?? []);
        Map<String, int> topicsPerCategory = {};
        for (var element in tagsList) {
          final mySnapshot = await FirebaseFirestore.instance
              .collection(topicsCollection)
              .where('tags', arrayContains: element)
              .get();
          int numOfTopics = mySnapshot.docs.length;
          topicsPerCategory[element] = numOfTopics;
        }

        return topicsPerCategory;
      } else {
        throw Exception('Invalid data format or document not found.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw Exception('Failed to fetch category topics: $e');
    }
  }

  Future<Map<String, int>> getUsersAge() async {
    final usersRef = FirebaseFirestore.instance.collection(usersCollection);
    final querySnapshot = await usersRef.get();
    Map<String, int> usersPerAge = {
      '15-19': 0,
      '20-29': 0,
      '30-39': 0,
      '40-49': 0,
      '50-59': 0,
      '>60': 0
    };

    for (var doc in querySnapshot.docs) {
      int timestamp = doc.get('dateOfBirth');
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      // Calculate age
      Duration ageDifference = DateTime.now().difference(dateTime);
      int age = ageDifference.inDays ~/ 365; // Approximate age in years

      // Update usersPerAge map
      if (age >= 15) {
        if (age < 20) {
          usersPerAge['15-19'] = usersPerAge['15-19']! + 1;
        } else if (age < 30) {
          usersPerAge['20-29'] = usersPerAge['20-29']! + 1;
        } else if (age < 40) {
          usersPerAge['30-39'] = usersPerAge['30-39']! + 1;
        } else if (age < 50) {
          usersPerAge['40-49'] = usersPerAge['40-49']! + 1;
        } else if (age < 60) {
          usersPerAge['50-59'] = usersPerAge['50-59']! + 1;
        } else {
          usersPerAge['>60'] = usersPerAge['>60']! + 1;
        }
      }
    }

    return usersPerAge;
  }
}
