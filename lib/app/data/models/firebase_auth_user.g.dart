// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseAuthUser _$FirebaseAuthUserFromJson(Map<String, dynamic> json) =>
    FirebaseAuthUser(
      json['id'] as String,
      json['email'] as String,
      json['displayName'] as String,
      json['role'] as String,
      json['lastSignInTime'] as String,
      json['creationTime'] as String,
      json['photoURL'] as String,
    );

Map<String, dynamic> _$FirebaseAuthUserToJson(FirebaseAuthUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'role': instance.role,
      'lastSignInTime': instance.lastSignInTime,
      'creationTime': instance.creationTime,
      'photoURL': instance.photoURL,
    };
