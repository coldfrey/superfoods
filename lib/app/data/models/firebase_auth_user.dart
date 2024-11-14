import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:superfoods/app/data/models/identifier_model.dart';
import 'package:superfoods/app/helpers/services/json_decoder.dart';

part 'firebase_auth_user.g.dart';

@JsonSerializable()
class FirebaseAuthUser extends IdentifierModel {
  final String email, displayName, role, lastSignInTime, creationTime, photoURL;

  FirebaseAuthUser(
    super.id,
    this.email,
    this.displayName,
    this.role,
    this.lastSignInTime,
    this.creationTime,
    this.photoURL,
  ) {
    print(
      'FirebaseAuthUser: $id, $email, $displayName, $role, $lastSignInTime, $creationTime, $photoURL',
    );
  }

  static FirebaseAuthUser fromJSON(Map<String, dynamic> json) {
    print('FirebaseAuthUser fromJSON: $json');
    JSONDecoder decoder = JSONDecoder(json);
    print('Decoder: $decoder');
    String email = decoder.getString('email');
    String displayName = decoder.getString('displayName');
    String role = decoder.getString('role');
    String lastSignInTime = decoder.getString('lastSignInTime');
    String creationTime = decoder.getString('creationTime');
    String photoURL = decoder.getString('photoURL');

    return FirebaseAuthUser(
      decoder.getId,
      email,
      displayName,
      role,
      lastSignInTime,
      creationTime,
      photoURL,
    );
  }

  static Map<String, FirebaseAuthUser> mapFromJSON(Map<String, dynamic> map) {
    return map
        .map((key, value) => MapEntry(key, FirebaseAuthUser.fromJSON(value)));
  }

  static List<FirebaseAuthUser> listFromJSON(List<dynamic> list) {
    return list.map((e) => FirebaseAuthUser.fromJSON(e)).toList();
  }

  // from firestore data
  // static FirebaseAuthUser fromFirestore(Map<String, dynamic> data) {
  //   return FirebaseAuthUser(
  //     data['id'],
  //     data['email'],
  //     data['displayName'],
  //     data['role'],
  //     data['lastSignInTime'],
  //     data['creationTime'],
  //     data['photoURL'],
  //   );
  // }
  factory FirebaseAuthUser.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FirebaseAuthUser.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  factory FirebaseAuthUser.fromJson(Map<String, dynamic> json) =>
      _$FirebaseAuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseAuthUserToJson(this);

  static List<FirebaseAuthUser>? _dummyList;

  static Future<List<FirebaseAuthUser>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!.sublist(0, 3);
  }

  static Future<String> getData() async {
    return await rootBundle
        .loadString('assets/datas/firebase_auth_user_data.json');
  }
}
