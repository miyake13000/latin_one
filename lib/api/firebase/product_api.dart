import 'package:cloud_firestore/cloud_firestore.dart';

import '../product_api.dart';
import '../../models/product.dart';

class FirebaseProductAPI implements ProductAPI {
    final FirebaseFirestore db;
    FirebaseProductAPI({required this.db});

    @override
    Future<List<Product>> fetchProduct() async {
        List<Product> products = [];

        // Fetch collections
        QuerySnapshot snapshot = await db.collection("products").get();

        // Create data model instances from document snapshots
        for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            products.add(Product.fromJson(data));
        }
        return products;
    }
}
