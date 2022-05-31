import 'package:cloud_firestore/cloud_firestore.dart';
class UserRepository {
  String apiKey = "8d8becf9938726356f5f42d57fd96f9e9b014f8fd754c7b1b62d4c4a0814";
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
