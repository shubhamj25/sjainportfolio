import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  Future<Map<String, dynamic>> getUserData(String userId) async {
    DocumentSnapshot data;
    data = await FirebaseFirestore.instance
        .collection("profile")
        .doc(userId)
        .get();
    return data.data();
  }

  void logEngagingUser(String name, String email) async {
    await FirebaseFirestore.instance
        .collection("engagingUsers")
        .doc(email)
        .set({'name': name, 'email': email});
  }
}
