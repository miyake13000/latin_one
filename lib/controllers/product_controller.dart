import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
import '../providers.dart';

class ProductController extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() {
    final api = ref.watch(productAPIProvider);
    return api.fetchProduct();
  }
}
