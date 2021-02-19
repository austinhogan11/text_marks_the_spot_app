import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
String usersCollection = 'users';

bool saveNewUser(String email, String uid, String username) {
  if (username != null && username.isNotEmpty) {
    _firestore.collection(usersCollection).add(
      {
        'email': email,
        'uid': uid,
        'username': username,
      },
    );
    print('New User Added to TMTS DB:\n'
        'Email: $email\n'
        'uid: $uid\n'
        'Username: $username');
    return true;
  }
  return false;
}
