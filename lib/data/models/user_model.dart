// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? phoneNumber;
  DateTime? dateOfBirth;
  String? profilePicture;
  List? followers;
  List? following;
  List? topics;
  bool? isAnonymous;
  bool? isAdmin;
  UserModel({
    this.uid,
    this.username,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.profilePicture,
    this.followers,
    this.following,
    this.topics,
    this.isAnonymous,
    this.isAdmin,
  });

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? profilePicture,
    List? followers,
    List? following,
    List? topics,
    bool? isAnonymous,
    bool? isAdmin,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profilePicture: profilePicture ?? this.profilePicture,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      topics: topics ?? this.topics,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'profilePicture': profilePicture,
      'followers': followers,
      'following': following,
      'topics': topics,
      'isAnonymous': isAnonymous,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String?,
      username: map['username'] as String?,
      email: map['email'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int)
          : null,
      profilePicture: map['profilePicture'] as String?,
      followers: (map['followers'] as List<dynamic>?) ?? [], // Handle null case
      following: (map['following'] as List<dynamic>?) ?? [], // Handle null case
      topics: (map['topics'] as List<dynamic>?) ?? [], // Handle null case
      isAnonymous: map['isAnonymous'] as bool?,
      isAdmin: map['isAdmin'] as bool?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, username: $username, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, profilePicture: $profilePicture, followers: $followers, following: $following, topics: $topics, isAnonymous: $isAnonymous, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.username == username &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.dateOfBirth == dateOfBirth &&
        other.profilePicture == profilePicture &&
        other.followers == followers &&
        other.following == following &&
        other.topics == topics &&
        other.isAnonymous == isAnonymous &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        dateOfBirth.hashCode ^
        profilePicture.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        topics.hashCode ^
        isAnonymous.hashCode ^
        isAdmin.hashCode;
  }
}
