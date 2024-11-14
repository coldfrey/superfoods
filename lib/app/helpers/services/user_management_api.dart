import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:superfoods/app/data/models/firebase_auth_user.dart';

class UserManagementApi {
  static const String _baseUrl =
      'https://europe-west1-co2-target-asset-tracking.cloudfunctions.net/userRolesApi';
  // 'https://co2-target-asset-tracking.web.app/api/users';

  // create user
  static Future<void> createUser({
    required String email,
    required String password,
    required String displayName,
  }) async {
    final url = Uri.parse('$_baseUrl/users');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${FirebaseAuth.instance.currentUser!.getIdToken()}',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'displayName': displayName,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
      print('User created successfully');
    } else {
      // Handle error
      // raise an exception
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  static Future<List<FirebaseAuthUser>> listUsers() async {
    final url = Uri.parse('$_baseUrl/users');
    final response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer ${FirebaseAuth.instance.currentUser!.getIdToken()}',
      },
    );

    if (response.statusCode == 200) {
      // Parse the JSON response and return the list of users
      List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((user) => user as Map<String, dynamic>).toList()
          as List<FirebaseAuthUser>;
    } else {
      // Handle error
      throw Exception('Failed to list users: ${response.statusCode}');
    }
  }

  // get user
  static Future<FirebaseAuthUser> getUser(String id) async {
    final url = Uri.parse('$_baseUrl/users/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer ${FirebaseAuth.instance.currentUser!.getIdToken()}',
      },
    );

    if (response.statusCode == 200) {
      // Handle success
      return FirebaseAuthUser.fromJson(jsonDecode(response.body));
    } else {
      // Handle error
      throw Exception('Failed to get user: ${response.statusCode}');
    }
  }

  // update user
  static Future<void> updateUser(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final url = Uri.parse('$_baseUrl/users/$id');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${FirebaseAuth.instance.currentUser!.getIdToken()}',
      },
      body: jsonEncode(updates),
    );

    if (response.statusCode == 200) {
      // Handle success
      print('User updated successfully');
    } else {
      // Handle error
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  // delete user
  static Future<void> deleteUser(String id) async {
    final url = Uri.parse('$_baseUrl/users/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      // Handle success
      print('User deleted successfully');
    } else {
      // Handle error
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }

  static Future<dynamic> uploadUserPhoto(String id, String filePath) async {
    final url = Uri.parse('$_baseUrl/users/$id/photo');

    // Read the file and encode it to base64
    final bytes = await File(filePath).readAsBytes();
    final base64Image = base64Encode(bytes);
    final filename = filePath.split('/').last;

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'imageData': base64Image,
        'filename': filename,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response body to get the download URL
      final responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      // Handle error
      throw Exception('Failed to upload photo: ${response.statusCode}');
    }
  }
}
