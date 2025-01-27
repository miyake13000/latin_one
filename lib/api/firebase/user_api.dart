import 'package:cloud_firestore/cloud_firestore.dart';

import '../user_api.dart';
import '../../models/user.dart';

class FirebaseUserAPI implements UserAPI {
    final FirebaseFirestore db;
    FirebaseUserAPI({required this.db});

    @override
    Future<void> saveUser(User user) async {
        await firestore.collection("users").doc(user.uid).set(user.toJson());
    }

    @override
    Future<User> fetchUser(String uid) async {
        DocumentSnapshot userSnapshot = await firestore.collection("users").doc(uid).get();
        return User.fromJson(userSnapshot.data() as Map<String, dynamic>);
    }

}
