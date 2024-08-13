import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethod {
  Future<void> addUser(Map<String, dynamic> userInfo, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users") // Ensure this matches your Firestore collection name
          .doc(id)
          .set(userInfo);
    } catch (e) {
      print("Error adding user: $e");
      throw e;
    }
  }
}
