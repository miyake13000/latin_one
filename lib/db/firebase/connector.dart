import 'package:cloud_firestore/cloud_firestore.dart';
import '../../resources/store.dart';
import '../../resources/product.dart';

// Fetch Products from Firestore
Future<List<Product>> fetchProduct(FirebaseFirestore db) async {
    List<Product> products = [];

    // Fetch collections
    QuerySnapshot snapshot = await db.collection(Product.collectionPath()).get();

    // Create data model instances from document snapshots
    for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        products.add(Product.fromMap(data));
    }

    return products;
}

// Fetch Stores from Firestore
Future<List<Store>> fetchStore(FirebaseFirestore db) async {
    List<Store> stores = [];

    // Fetch collections
    QuerySnapshot snapshot = await db.collection(Store.collectionPath()).get();

    // Create data model instances from document snapshots
    for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        stores.add(Store.fromMap(data));
    }

    return stores;
}
