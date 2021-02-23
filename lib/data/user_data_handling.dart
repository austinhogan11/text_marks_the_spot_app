import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataHandling {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  DocumentReference userDoc;

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

  Future getUsername(String userUID) async {
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
}
