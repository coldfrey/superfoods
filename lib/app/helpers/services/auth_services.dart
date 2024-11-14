import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:superfoods/app/helpers/storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart'; //
import 'package:image_picker/image_picker.dart';

import 'navigation_service.dart';
import 'user_management_api.dart';

class AuthService extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Reactive State Management
  final Rxn<User> firebaseUser = Rxn<User>();
  RxMap<String, dynamic> userRoles = RxMap<String, dynamic>();

  User? get user => firebaseUser.value;
  bool get isLoggedIn => firebaseUser.value != null;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(
      _firebaseAuth.authStateChanges(),
    ); // Bind stream to listen to authentication state changes
    firebaseUser.listen((User? user) async {
      if (user != null) {
        userRoles.value = await _fetchAndSetUserRoles() ?? {};
      } else {
        userRoles.clear();
      }
    });
  }

  Future<Map<String, String>?> registerUser(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      // Optionally update the display name with the first and last names
      await user?.updateDisplayName("$firstName $lastName");
      return null; // Return null on successful registration
    } catch (e) {
      if (e is FirebaseAuthException) {
        return {e.code: e.message ?? "An error occurred"};
      }
      return {'error': 'An unexpected error occurred during registration'};
    }
  }

  Future<Map<String, String>?> loginUser(String email, String password) async {
    try {
      // Attempt to sign in the user using Firebase Auth
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        firebaseUser.value = userCredential.user; // Update the observable user
        return null; // Return null to signify success
      }
      return {
        'error': 'Unknown error occurred',
      }; // Generic error if no user found (shouldn't happen in theory)
    } catch (e) {
      if (e is FirebaseAuthException) {
        return {
          'error': e.message ?? 'An error occurred',
        }; // Return specific Firebase auth error messages
      }
      return {'error': 'An error occurred'};
    }
  }

  Future<void> signOut() async {
    if (kDebugMode) {
      final username = firebaseUser.value?.displayName;
      print('Signing out user: $username');
    }
    await _firebaseAuth.signOut();
    firebaseUser.value = null; // Clear the user value on sign out
  }

  static Future<Map<String, String>?> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null; // On successful sending, return null
    } catch (e) {
      // Handle exceptions and return a map of errors
      if (e is FirebaseAuthException) {
        return {e.code: e.message ?? "An error occurred"};
      }
      return {'error': 'An unexpected error occurred'};
    }
  }

  static Future<Map<String, String>?> sendOneTimeLoginEmail(
    String email,
  ) async {
    // baseUrl of the app
    String baseUrl;
    if (kDebugMode) {
      baseUrl = "http://localhost:41151";
    } else {
      baseUrl = "https://co2-target-asset-tracking.web.app";
    }

    var acs = ActionCodeSettings(
      url: '$baseUrl/auth/login-link',
      // This must be true
      handleCodeInApp: true,
    );

    FirebaseAuth.instance
        .sendSignInLinkToEmail(email: email, actionCodeSettings: acs)
        .catchError(
          (onError) => print('Error sending email verification $onError'),
        )
        .then((value) async {
      // save email to local storage
      await LocalStorage.setUserEmailSignInLink(email);
    });

    return null;
  }

  static Future<void> signInWithEmailLink(String emailLink) async {
    // Check if the link is a sign-in link
    final bool isLink = FirebaseAuth.instance.isSignInWithEmailLink(emailLink);

    if (isLink) {
      // get email from local storage if exists
      String? email = LocalStorage.getUserEmailSignInLink();

      if (email == null) {
        print('No email found');
        // return
        return;
      }

      try {
        // attempt to sign in with email link
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailLink(email: email, emailLink: emailLink);

        // clear email from local storage
        await LocalStorage.setUserEmailSignInLink('');

        // Additional user info can be accessed through userCredential.additionalUserInfo
        // For example, to check if the user is new:
        // final bool isNewUser =
        //     userCredential.additionalUserInfo?.isNewUser ?? false;
        print("Successful sign in");

        // NavigationService.toNamed('/all-projects');
        // redirect to reset password page
        NavigationService.toNamed('/auth/reset-password');
      } catch (error) {
        print('Error signing in with email link: $error');
      }
    }
  }

  // Get user roles from custom claims
  Future<Map<String, dynamic>?> _fetchAndSetUserRoles() async {
    if (!isLoggedIn) return null;
    final idTokenResult = await firebaseUser.value!.getIdTokenResult(true);
    // print('User roles: ${idTokenResult.claims}');
    return idTokenResult.claims;
  }

  bool hasRole(String role) {
    return userRoles['role'] == role;
  }

  Future<bool> setUserRole(String uid, String role) async {
    // TODO modify to use rest api
    final HttpsCallable callable =
        FirebaseFunctions.instanceFor(region: 'europe-west1').httpsCallable(
      'setUserRole',
    );

    try {
      print('setting role for $uid with role $role');
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'uid': uid,
          'role': role,
        },
      );
      if (kDebugMode) {
        print('role set $result');
      }
      // refresh user auth token
      print('refreshing user token');
      userRoles.value = (await _fetchAndSetUserRoles())!;
      return true;
    } on FirebaseFunctionsException catch (e) {
      if (kDebugMode) {
        print('FirebaseFunctionsException:');
        print(e.code);
        print(e.message);
        print(e.details);
      }
    }
    return false;
  }

  // Future<List<FirebaseAuthUser>> loadAllUsers() async {
    // final functionsService = Get.find<FirebaseFunctionService>();
    // return await functionsService.callListFunction<FirebaseAuthUser>(
    //   'listUsers',
    //   listKey: 'users',
    // ) as List<FirebaseAuthUser>;

  //   return await UserManagementApi.listUsers();
  // }

  Future<Map<String, String>?> updateDisplayName({
    String? firstName,
    String? lastName,
  }) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String displayName =
          "${firstName ?? user.displayName?.split(' ').first} ${lastName ?? user.displayName?.split(' ').last}"
              .trim();
      try {
        await user.updateDisplayName(displayName);
        firebaseUser.value = _firebaseAuth
            .currentUser; // Refresh the user info in the observable

        return null; // Return null on successful update
      } catch (e) {
        if (e is FirebaseAuthException) {
          return {e.code: e.message ?? "Failed to update profile"};
        }
        return {'error': 'An unexpected error occurred during profile update'};
      }
    }
    return {'error': 'No user logged in'};
  }

  Future<Map<String, String>?> updateUserPhotoURL(String photoURL) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.updatePhotoURL(photoURL);
        firebaseUser.value = _firebaseAuth
            .currentUser; // Refresh the user info in the observable
        return null; // Return null on successful update
      } catch (e) {
        if (e is FirebaseAuthException) {
          return {e.code: e.message ?? "Failed to update profile"};
        }
        return {'error': 'An unexpected error occurred during profile update'};
      }
    }
    return {'error': 'No user logged in'};
  }

  Future<Map<String, String>?> updatePassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
      return null; // Success
    } catch (e) {
      if (e is FirebaseAuthException) {
        return {e.code: e.message ?? "An error occurred"};
      }
      return {'error': 'An unexpected error occurred during password update'};
    }
  }

  Future<String> uploadProfileImageToFirebaseStorage(XFile image) async {
    // // Upload the image to Firebase Storage
    // final HttpsCallable callable =
    //     FirebaseFunctions.instanceFor(region: 'europe-west1').httpsCallable(
    //   'uploadUserPhotoToBucket',
    // );
    // // List<int> bytes =
    // //     utf8.encode(await image.readAsString()); // Convert string to bytes
    // final String encodedBase64 =
    //     base64Encode(await image.readAsBytes()); // Encoding bytes to Base64
    // // print("Encoded Base64: $encodedBase64");
    // // print('file as string `$encodedBase64`');
    // String downloadURL = '';
    // try {
    //   final HttpsCallableResult result = await callable.call(
    //     <String, dynamic>{
    //       'uid': user!.uid,
    //       'imageData': encodedBase64,
    //       'filename': image.name,
    //     },
    //   );
    //   if (kDebugMode) {
    //     print('the response:');
    //     print('${result.data}');
    //   }
    //   downloadURL = result.data['downloadURL'];
    // } on FirebaseFunctionsException catch (e) {
    //   if (kDebugMode) {
    //     print('FirebaseFunctionsException:');
    //     print(e.code);
    //     print(e.message);
    //     print(e.details);
    //   }
    // }

    try {
      final response =
          await UserManagementApi.uploadUserPhoto(user!.uid, image.name);

      return response["downloadURL"];
    } catch (e) {
      if (kDebugMode) {
        print('FirebaseFunctionsException:');
        print(e);
      }
      return '';
    }

    // return downloadURL;
  }
}
