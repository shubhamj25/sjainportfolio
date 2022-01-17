import 'package:cloud_firestore/cloud_firestore.dart';
class UserRepository {
  Future<Map<String,dynamic>> getUserData(String userId) async {
    DocumentSnapshot data;
    data = await FirebaseFirestore.instance
        .collection("profile")
        .doc(userId)
        .get();
    return data.data();
  }
}