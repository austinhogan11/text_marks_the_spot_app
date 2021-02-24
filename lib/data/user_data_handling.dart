import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
  Data Handling Class for the users collection in Firestore
 */

class UserDataHandling {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  DocumentReference userDoc;

  /*
    Adds a newly created account to the users collection
    The document ID is saved as the Firebase Auth UID code
    The email & username for the user are saved
   */
  bool saveNewUser(String email, String uid, String username) {
    if (username != null && username.isNotEmpty) {
      users.doc(uid).set({
        'email': email,
        'username': username,
      }).then((value) {
        print('New User Added to TMTS DB:\n'
            'Email: $email\n'
            'Username: $username');
      }).catchError((e) => print('Failed to add user.'));
      return true;
    }
    return false;
  }

  //Finds the user in the users collection based on the currently logged in user's UID code
  // Returns the username eof the logged in user.
  Future<String> getUsername(String userUID) async {
    String username;
    try {
      await users.doc(userUID).get().then((value) {
        username = value.data()["username"];
      });
      return username;
    } catch (e) {
      print(e);
      return null;
    }
  }

  bool updateUsername(String userUID, String newUsername) {
    if (newUsername != null && newUsername.isNotEmpty) {
      users
          .doc(userUID)
          .update({'username': newUsername})
          .then((value) => print("Username updated to $newUsername"))
          .catchError((e) => print("Could not update username: $e"));
      return true;
    }
    return false;
  }
}
