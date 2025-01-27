import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireauth;

import 'api/firebase/auth_api.dart';
import 'api/firebase/product_api.dart';
import 'api/firebase/store_api.dart';
import 'api/firebase/user_api.dart';

final authAPIProvider = Provider<FirebaseAuthAPI>((ref) {
    final auth = ref.watch(fireauthProvider);
    return FirebaseAuthAPI(auth: auth);
});

final productAPIProvider = Provider<FirebaseProductAPI>((ref) {
    final firestore = ref.watch(firestoreProvider);
    return FirebaseProductAPI(db: firestore);
});

final storeAPIProvider = Provider<FirebaseStoreAPI>((ref) {
    final firestore = ref.watch(firestoreProvider);
    return FirebaseStoreAPI(db: firestore);
});

final userAPIProvider = Provider<FirebaseUserAPI>((ref) {
    final firestore = ref.watch(firestoreProvider);
    return FirebaseUserAPI(db: firestore);
});

// For firebase
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
    return FirebaseFirestore.instance;
});

final fireauthProvider = Provider<fireauth.FirebaseAuth>((ref) {
    return fireauth.FirebaseAuth.instance;
});

