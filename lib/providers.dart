import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as fireauth;

import 'models/product.dart';
import 'models/store.dart';
import 'models/user.dart';
import 'models/order.dart';
import 'controllers/product_controller.dart';
import 'controllers/store_controller.dart';
import 'controllers/user_contoroller.dart';
import 'controllers/order_controller.dart';
import 'api/firebase/auth_api.dart';
import 'api/firebase/product_api.dart';
import 'api/firebase/store_api.dart';
import 'api/firebase/user_api.dart';

// controllers
final productProvider = AsyncNotifierProvider<ProductController, List<Product>>(
  ProductController.new
);

final storeProvider = AsyncNotifierProvider<StoreController, List<Store>>(
  StoreController.new
);

final userProvider = AsyncNotifierProvider<UserController, User?>(
  UserController.new
);

final orderProvider = NotifierProvider<OrderController, Order>(
  OrderController.new
);

// APIs
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
final firestoreProvider = Provider<firestore.FirebaseFirestore>((ref) {
    return firestore.FirebaseFirestore.instance;
});

final fireauthProvider = Provider<fireauth.FirebaseAuth>((ref) {
    return fireauth.FirebaseAuth.instance;
});

