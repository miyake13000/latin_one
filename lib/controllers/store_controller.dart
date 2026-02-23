import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../models/store.dart';

class StoreController extends AsyncNotifier<List<Store>> {
  @override
  Future<List<Store>> build() {
    final api = ref.watch(storeAPIProvider);
    return api.fetchStore();
  }
}
