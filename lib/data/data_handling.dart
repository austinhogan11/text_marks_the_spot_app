import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
  Data Handling Class for the users collection in Firestore
 */
final FirebaseAuth _auth = FirebaseAuth.instance;

class DataHandling {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  DocumentReference userDoc;

  final CollectionReference textmarks =
      FirebaseFirestore.instance.collection('textmarks');
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

  Future<void> saveTextMark(
      DateTime creationDate,
      DateTime expirationDate,
      String dateLabel,
      String senderUID,
      String recipientUsername,
      GeoPoint coordinates,
      String locationNickname,
      String messageContents) async {
    final User loggedInUser = _auth.currentUser;

    //Gets the uid of the entered username for the recipient
    String recipientUID;
    String senderUsername;
    await users.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            if (recipientUsername == doc['username']) {
              print(
                  'Username: $recipientUsername\nDocument Username: ${doc['username']}');
              print(doc.id);
              recipientUID = doc.id;
              print(recipientUID);
            }

            if (senderUID == doc.id) {
              senderUsername = doc['username'];
            }
          })
        });

    //Creates a new textmark document
    // textmarks
    //     .add({
    //       'creationDate': creationDate,
    //       'expirationDate': expirationDate,
    //       'dateLabel': dateLabel,
    //       'senderUID': loggedInUser.uid,
    //       'senderUsername': senderUsername,
    //       'recipientUID': recipientUID,
    //       'recipientUsername': recipientUsername,
    //       'coordinates': coordinates,
    //       'locationNickname': locationNickname,
    //       'message': messageContents,
    //     })
    //     .then((value) => print(
    //         'Textmark Saved:\nSender: ${loggedInUser.uid}\nRecipient: $recipientUID\nCoordinates: ${coordinates.longitude}, ${coordinates.latitude}\nLocation Nickname: $locationNickname\nMessage: $messageContents'))
    //     .catchError((e) => print('Failed to save Textmark.'));

    textmarks
        .doc("${loggedInUser.uid}${creationDate.toString()}")
        .set({
          'creationDate': creationDate,
          'expirationDate': expirationDate,
          'dateLabel': dateLabel,
          'senderUID': loggedInUser.uid,
          'senderUsername': senderUsername,
          'recipientUID': recipientUID,
          'recipientUsername': recipientUsername,
          'coordinates': coordinates,
          'locationNickname': locationNickname,
          'message': messageContents,
        })
        .then((value) => print(
            'Textmark Saved:\nSender: ${loggedInUser.uid}\nRecipient: $recipientUID\nCoordinates: ${coordinates.longitude}, ${coordinates.latitude}\nLocation Nickname: $locationNickname\nMessage: $messageContents'))
        .catchError((e) => print('Failed to save Textmark.'));
  }

  Future<void> deleteTextMark(String textmarkID) {
    return textmarks.doc(textmarkID).delete();
  }
}
