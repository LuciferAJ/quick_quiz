import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseModel {
  FirebaseAuth auth;
  final FirebaseDatabase _firebaseDatabase=FirebaseDatabase();

  uploadAPI(String subject, subjectData){
    print(subjectData);
    _firebaseDatabase.reference().child(FirebaseAuth.instance.currentUser.uid).child('subjects').child(subject).update(subjectData);
  }

  Future<void> setUser(uid, email) {
    print("uploading User");
    return FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).set({
      'email': email,
    });
  }

  Future<void> uploadUserDetails(details) {
    print("uploading user details");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update(details);
  }

  Future<DocumentSnapshot> getUserDetailsStatus(uid) async {
    return await FirebaseFirestore.instance.collection('users').doc(uid).get();
  }

}
