import 'package:blog_app/models/usermodel.dart';
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

  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print("User not found");
        return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }
}
