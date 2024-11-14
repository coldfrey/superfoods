import 'dart:math';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:superfoods/app/data/models/firebase_auth_user.dart';

class FirebaseFunctionService {
  final FirebaseFunctions functions =
      FirebaseFunctions.instanceFor(region: 'europe-west1');

  // Future<List<T>> callListFunction<T>(
  Future<List> callListFunction<T>(
    String functionName, {
    Map<String, dynamic>? parameters,
    String? listKey,
  }) async {
    try {
      HttpsCallable callable = functions.httpsCallable(functionName);
      print('Calling function $functionName with parameters $parameters');
      final HttpsCallableResult result = await callable.call(parameters);
      if (result.data is List) {
        return (result.data as List)
            .map<T>((item) => fromJson<T>(item))
            .toList();
      } else if (result.data is Map<String, dynamic> && listKey != null) {
        // print(result.data);
        if (result.data.containsKey(listKey)) {
          print('List key  ($listKey) found in data');
          var resultList = (result.data[listKey] as List);
          print('Result list: $resultList\n\n');
          resultList.map<T>((item) => fromJson<T>(item)).toList();
          print('Result list: $resultList');
          return resultList;
        } else {
          throw Exception("Key '$listKey' not found in data");
        }
      } else {
        // print(result.data);
        throw Exception(
          "Expected data to be a List or a Map containing the key '$listKey', but got ${result.data.runtimeType}",
        );
      }
    } on FirebaseFunctionsException catch (error) {
      if (kDebugMode) {
        print('FirebaseFunctionsException:');
        print(error.code);
        print(error.details);
        print(error.message);
      }
      throw Exception("Error calling function $functionName");
    }
  }

  Future<dynamic> callFunction(
    String name, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final HttpsCallable callable = functions.httpsCallable(name);
      final HttpsCallableResult result = await callable.call(parameters);
      return result.data;
    } catch (e) {
      throw Exception('Error calling function: $e');
    }
  }

  Future<void> callCreateFunction(
    String functionName,
    Map<String, dynamic> parameters,
  ) async {
    try {
      HttpsCallable callable = functions.httpsCallable(functionName);
      await callable.call(parameters);
      if (kDebugMode) {
        print('User successfully created with parameters $parameters');
      }
    } on FirebaseFunctionsException catch (error) {
      if (kDebugMode) {
        print('FirebaseFunctionsException when creating user:');
        print(error.code);
        print(error.details);
        print(error.message);
      }
      throw Exception(
        "Error creating user with function $functionName: ${error.message}",
      );
    }
  }

  dynamic fromJson<T>(dynamic json) {
    print('Converting JSON to type $T');
    // Provide conversion from JSON to your types here
    if (T == FirebaseAuthUser) {
      print('Converting to FirebaseAuthUser');
      // final user = FirebaseAuthUser.fromJson(json);
      final user = FirebaseAuthUser(
        json['uid'],
        json['email'],
        json['displayName'],
        json['photoURL'],
        json['role'],
        json['createdAt'] ?? 'unknown',
        json['updatedAt'],
      );
      print('User converted: $user');
      return user;
    } else {
      throw Exception(
        "Type $T is not supported by callListFunction's fromJson",
      );
    }
  }
}
