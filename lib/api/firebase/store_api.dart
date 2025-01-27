import 'package:cloud_firestore/cloud_firestore.dart';

import '../store_api.dart';
import '../../models/store.dart';

class FirebaseStoreAPI implements StoreAPI {
    final FirebaseFirestore db;
    FirebaseStoreAPI({required this.db});

    @override
    Future<List<Store>> fetchStore() async {
        List<Store> stores = [];

        // Fetch collections
        QuerySnapshot snapshot = await db.collection("stores").get();

        // Create data model instances from document snapshots
        for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            stores.add(Store.fromJson(data));
        }
        return stores;
    }
}
